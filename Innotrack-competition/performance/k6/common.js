import http from 'k6/http';
import { check } from 'k6';
import { Counter } from 'k6/metrics';

export const status2xx = new Counter('status_2xx');
export const status4xx = new Counter('status_4xx');
export const status5xx = new Counter('status_5xx');
export const businessErrors = new Counter('business_errors');

export const BASE_URL = __ENV.BASE_URL || 'http://host.docker.internal/prod-api';
export const ADMIN_USER = __ENV.ADMIN_USER || 'admin';
export const ADMIN_PASSWORD = __ENV.ADMIN_PASSWORD || 'admin123';
export const STUDENT_PASSWORD = __ENV.STUDENT_PASSWORD || 'admin123';
export const STUDENT_COUNT = Number(__ENV.STUDENT_COUNT || '80');

export function scenarioOptions(defaultVus = 10, defaultDuration = '30s') {
  return {
    vus: Number(__ENV.VUS || defaultVus),
    duration: __ENV.DURATION || defaultDuration,
    summaryTrendStats: ['avg', 'min', 'med', 'max', 'p(90)', 'p(95)', 'p(99)'],
  };
}

export function recordResponse(res) {
  if (res.status >= 200 && res.status < 300) {
    status2xx.add(1);
  } else if (res.status >= 400 && res.status < 500) {
    status4xx.add(1);
  } else if (res.status >= 500) {
    status5xx.add(1);
  }
}

export function parseJson(res) {
  try {
    return res.json();
  } catch (_) {
    return null;
  }
}

export function login(username, password) {
  const res = http.post(
    `${BASE_URL}/login`,
    JSON.stringify({ username, password, code: '', uuid: '' }),
    { headers: { 'Content-Type': 'application/json' } },
  );
  recordResponse(res);
  const body = parseJson(res);
  check(res, {
    [`login ${username} http 200`]: (r) => r.status === 200,
    [`login ${username} has token`]: () => Boolean(body && body.token),
  });
  if (!body || !body.token) {
    businessErrors.add(1);
    throw new Error(`login failed for ${username}: status=${res.status}, body=${res.body}`);
  }
  return body.token;
}

export function authHeaders(token) {
  return {
    Authorization: `Bearer ${token}`,
    'Content-Type': 'application/json',
  };
}

export function studentName(index) {
  return `loadtest_student_${String(index).padStart(3, '0')}`;
}

export function loadStudentTokens() {
  const tokens = [];
  for (let i = 1; i <= STUDENT_COUNT; i += 1) {
    tokens.push(login(studentName(i), STUDENT_PASSWORD));
  }
  return tokens;
}

export function loadCompetitionIds(prefix, pageSize = 500) {
  const res = http.get(`${BASE_URL}/student/hall/list?pageNum=1&pageSize=${pageSize}&competitionName=${encodeURIComponent(prefix)}`);
  recordResponse(res);
  const body = parseJson(res);
  const rows = body && Array.isArray(body.rows) ? body.rows : [];
  check(res, {
    [`load competitions ${prefix} http 200`]: (r) => r.status === 200,
    [`load competitions ${prefix} non-empty`]: () => rows.length > 0,
  });
  if (!rows.length) {
    businessErrors.add(1);
    throw new Error(`no competitions found for prefix ${prefix}`);
  }
  return rows.map((row) => row.competitionId || row.competition_id).filter(Boolean);
}

export function loadPendingApplyIds(adminToken, pageSize = 10000) {
  const res = http.get(`${BASE_URL}/system/competition/audit/apply/list?pageNum=1&pageSize=${pageSize}&auditStatus=0&competitionName=loadtest_audit_`, {
    headers: authHeaders(adminToken),
  });
  recordResponse(res);
  const body = parseJson(res);
  const rows = body && Array.isArray(body.rows) ? body.rows : [];
  check(res, {
    'load pending audit http 200': (r) => r.status === 200,
    'load pending audit non-empty': () => rows.length > 0,
  });
  if (!rows.length) {
    businessErrors.add(1);
    throw new Error('no pending audit records found');
  }
  return rows.map((row) => row.applyId || row.apply_id).filter(Boolean);
}

export function assertBusinessOk(res, operation) {
  const body = parseJson(res);
  const ok = res.status >= 200 && res.status < 300 && (!body || body.code === 200);
  check(res, {
    [`${operation} business ok`]: () => ok,
  });
  if (!ok) {
    businessErrors.add(1);
  }
  return ok;
}
