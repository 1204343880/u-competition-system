import http from 'k6/http';
import exec from 'k6/execution';
import { ADMIN_PASSWORD, ADMIN_USER, assertBusinessOk, authHeaders, BASE_URL, loadPendingApplyIds, login, recordResponse, scenarioOptions } from './common.js';

export const options = scenarioOptions(10, '30s');

export function setup() {
  const adminToken = login(ADMIN_USER, ADMIN_PASSWORD);
  return {
    adminToken,
    applyIds: loadPendingApplyIds(adminToken, 10000),
  };
}

export default function (data) {
  const i = exec.scenario.iterationInTest;
  const applyId = data.applyIds[i % data.applyIds.length];
  const auditStatus = i % 5 === 0 ? '2' : '1';
  const res = http.put(`${BASE_URL}/system/competition/audit/apply`, JSON.stringify({
    applyId,
    auditStatus,
    auditRemark: 'loadtest audit',
  }), {
    headers: authHeaders(data.adminToken),
  });
  recordResponse(res);
  assertBusinessOk(res, 'audit');
}
