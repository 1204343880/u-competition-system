import http from 'k6/http';
import exec from 'k6/execution';
import { ADMIN_PASSWORD, ADMIN_USER, assertBusinessOk, authHeaders, BASE_URL, loadCompetitionIds, loadPendingApplyIds, loadStudentTokens, login, recordResponse, scenarioOptions } from './common.js';

export const options = scenarioOptions(100, '60s');

export function setup() {
  const adminToken = login(ADMIN_USER, ADMIN_PASSWORD);
  return {
    adminToken,
    studentTokens: loadStudentTokens(),
    listCompetitionIds: loadCompetitionIds('loadtest_', 500),
    applyCompetitionIds: loadCompetitionIds('loadtest_apply_', 500),
    applyIds: loadPendingApplyIds(adminToken, 10000),
  };
}

export default function (data) {
  const i = exec.scenario.iterationInTest;
  const bucket = i % 10;
  if (bucket < 7) {
    const res = http.get(`${BASE_URL}/student/hall/list?pageNum=1&pageSize=20&competitionName=loadtest_&sortBy=apply`);
    recordResponse(res);
    return;
  }

  if (bucket < 9) {
    const token = data.studentTokens[i % data.studentTokens.length];
    const competitionId = data.applyCompetitionIds[Math.floor(i / data.studentTokens.length) % data.applyCompetitionIds.length];
    const res = http.post(`${BASE_URL}/student/hall/${competitionId}/apply`, null, {
      headers: authHeaders(token),
    });
    recordResponse(res);
    assertBusinessOk(res, 'mixed apply');
    return;
  }

  const applyId = data.applyIds[i % data.applyIds.length];
  const res = http.put(`${BASE_URL}/system/competition/audit/apply`, JSON.stringify({
    applyId,
    auditStatus: '1',
    auditRemark: 'loadtest mixed audit',
  }), {
    headers: authHeaders(data.adminToken),
  });
  recordResponse(res);
  assertBusinessOk(res, 'mixed audit');
}
