import http from 'k6/http';
import { check } from 'k6';
import { BASE_URL, parseJson, recordResponse, scenarioOptions } from './common.js';

export const options = scenarioOptions(10, '30s');

export default function () {
  const res = http.get(`${BASE_URL}/student/hall/list?pageNum=1&pageSize=20&competitionName=loadtest_&sortBy=apply`);
  recordResponse(res);
  check(res, {
    'list http 200': (r) => r.status === 200,
    'list has rows': (r) => {
      const body = parseJson(r);
      return body && Array.isArray(body.rows);
    },
  });
}
