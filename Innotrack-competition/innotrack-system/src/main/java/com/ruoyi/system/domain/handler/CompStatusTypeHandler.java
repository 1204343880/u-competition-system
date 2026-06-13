package com.ruoyi.system.domain.handler;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedJdbcTypes;
import org.apache.ibatis.type.MappedTypes;
import com.ruoyi.system.domain.CompStatus;

/**
 * CompStatus 枚举 ↔ 数据库 CHAR(1) 自动转换
 * 数据库存 "0"/"1"/"2"，Java 层用 DRAFT/REGISTERING/...
 */
@MappedTypes(CompStatus.class)
@MappedJdbcTypes(JdbcType.CHAR)
public class CompStatusTypeHandler extends BaseTypeHandler<CompStatus>
{
    @Override
    public void setNonNullParameter(PreparedStatement ps, int i, CompStatus parameter, JdbcType jdbcType) throws SQLException
    {
        ps.setString(i, parameter.getCode());
    }

    @Override
    public CompStatus getNullableResult(ResultSet rs, String columnName) throws SQLException
    {
        String value = rs.getString(columnName);
        return value == null ? null : CompStatus.fromCode(value);
    }

    @Override
    public CompStatus getNullableResult(ResultSet rs, int columnIndex) throws SQLException
    {
        String value = rs.getString(columnIndex);
        return value == null ? null : CompStatus.fromCode(value);
    }

    @Override
    public CompStatus getNullableResult(CallableStatement cs, int columnIndex) throws SQLException
    {
        String value = cs.getString(columnIndex);
        return value == null ? null : CompStatus.fromCode(value);
    }
}
