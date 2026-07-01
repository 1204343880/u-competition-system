import http from 'k6/http';
import exec from 'k6/execution';
import { BASE_URL, assertBusinessOk, authHeaders, loadCompetitionIds, loadStudentTokens, recordResponse, scenarioOptions } from './common.js';

export const options = scenarioOptions(10, '30s');

export function setup() {
  return {
    tokens: loadStudentTokens(),
    competitionIds: loadCompetitionIds('loadtest_apply_', 500),
  };
}

export default function (data) {
  const i = exec.scenario.iterationInTest;
  const token = data.tokens[i % data.tokens.length];
  const competitionId = data.competitionIds[Math.floor(i / data.tokens.length) % data.competitionIds.length];
  const res = http.post(`${BASE_URL}/student/hall/${competitionId}/apply`, null, {
    headers: authHeaders(token),
  });
  recordResponse(res);
  assertBusinessOk(res, 'apply');
}
