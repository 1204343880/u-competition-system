package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.system.domain.Competition;
import com.ruoyi.system.mapper.CompetitionMapper;
import com.ruoyi.system.service.ICompetitionService;

@Service
public class CompetitionServiceImpl implements ICompetitionService
{
    @Autowired
    private CompetitionMapper competitionMapper;

    @Autowired
    private RedisCache redisCache;

    private static final String CACHE_KEY_PREFIX = "competition:detail:";
    private static final int CACHE_BASE_MINUTES = 30;
    private static final int CACHE_JITTER_MINUTES = 10;
    /* 哨兵对象参数：标记"数据库不存在"的请求，防缓存穿透 */
    private static final Long SENTINEL_ID = -1L;
    private static final int SENTINEL_BASE_MINUTES = 5;
    private static final int SENTINEL_JITTER_MINUTES = 2;

    @Override
    public Competition selectCompetitionById(Long competitionId)
    {
        String cacheKey = CACHE_KEY_PREFIX + competitionId;
        Competition cached = redisCache.getCacheObject(cacheKey);
        if (cached != null)
        {
            if (SENTINEL_ID.equals(cached.getCompetitionId()))
            {
                return null;
            }
            return cached;
        }
        Competition comp = competitionMapper.selectCompetitionById(competitionId);
        if (comp != null)
        {
            redisCache.setCacheObjectWithJitter(cacheKey, comp, CACHE_BASE_MINUTES, CACHE_JITTER_MINUTES);
        }
        else
        {
            Competition sentinel = new Competition();
            sentinel.setCompetitionId(SENTINEL_ID);
            redisCache.setCacheObjectWithJitter(cacheKey, sentinel, SENTINEL_BASE_MINUTES, SENTINEL_JITTER_MINUTES);
        }
        return comp;
    }

    @Override
    public List<Competition> selectCompetitionList(Competition competition)
    {
        return competitionMapper.selectCompetitionList(competition);
    }

    @Override
    public List<Competition> selectCompetitionManageList(Competition competition)
    {
        return competitionMapper.selectCompetitionManageList(competition);
    }

    @Override
    public int insertCompetition(Competition competition)
    {
        if (competition.getPublishStatus() == null)
        {
            competition.setPublishStatus("0");
        }
        return competitionMapper.insertCompetition(competition);
    }

    @Override
    public int updateCompetition(Competition competition)
    {
        Competition exist = competitionMapper.selectCompetitionById(competition.getCompetitionId());
        if (exist == null)
        {
            throw new ServiceException("竞赛不存在");
        }
        int rows = competitionMapper.updateCompetition(competition);
        redisCache.deleteObject(CACHE_KEY_PREFIX + competition.getCompetitionId());
        return rows;
    }

    @Override
    public int deleteCompetitionByIds(Long[] competitionIds)
    {
        for (Long id : competitionIds)
        {
            redisCache.deleteObject(CACHE_KEY_PREFIX + id);
        }
        return competitionMapper.deleteCompetitionByIds(competitionIds);
    }

    @Override
    public int updatePublishStatus(Competition competition)
    {
        Competition exist = competitionMapper.selectCompetitionById(competition.getCompetitionId());
        if (exist == null)
        {
            throw new ServiceException("竞赛不存在");
        }
        if ("0".equals(competition.getPublishStatus()))
        {
            String cur = exist.getPublishStatus();
            if (!"0".equals(cur) && !"2".equals(cur))
            {
                throw new ServiceException("仅草稿和已关闭的竞赛可以退回草稿");
            }
        }
        int rows = competitionMapper.updatePublishStatus(competition);
        redisCache.deleteObject(CACHE_KEY_PREFIX + competition.getCompetitionId());
        return rows;
    }

    @Override
    public boolean incrementParticipants(Long competitionId)
    {
        return competitionMapper.incrementParticipants(competitionId) > 0;
    }

    @Override
    public void decrementParticipants(Long competitionId)
    {
        competitionMapper.decrementParticipants(competitionId);
    }
}
