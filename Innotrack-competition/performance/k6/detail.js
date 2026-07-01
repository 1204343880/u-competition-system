import http from 'k6/http';
import exec from 'k6/execution';
import { check } from 'k6';
import { BASE_URL, loadCompetitionIds, parseJson, recordResponse, scenarioOptions } from './common.js';

export const options = scenarioOptions(10, '30s');

export function setup() {
  return { competitionIds: loadCompetitionIds('loadtest_', 500) };
}

export default function (data) {
  const ids = data.competitionIds;
  const id = ids[exec.scenario.iterationInTest % ids.length];
  const res = http.get(`${BASE_URL}/student/hall/${id}`);
  recordResponse(res);
  check(res, {
    'detail http 200': (r) => r.status === 200,
    'detail business 200': (r) => {
      const body = parseJson(r);
      return body && body.code === 200;
    },
  });
}
