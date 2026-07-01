# InnoTrack CI/CD 部署说明

本项目的 CI/CD 目标是：代码推送到 GitHub `main` 分支后，由 GitHub Actions 完成 Maven 构建、前端构建、Docker 镜像构建与推送，然后通过 SSH 登录服务器拉取镜像并执行 `docker compose up -d`。

服务器只负责运行容器，不在服务器上编译 Maven 或 npm，适合 2C2G 这类资源较紧的机器。

## 新增文件

| 文件 | 作用 |
| --- | --- |
| `.github/workflows/deploy.yml` | GitHub Actions 构建、推镜像、SSH 部署流水线 |
| `Dockerfile.app` | 后端运行镜像，只复制已构建好的 `innotrack-admin.jar` |
| `Dockerfile.nginx` | 前端 nginx 镜像，内置 `innotrack-ui/dist` 和 nginx 配置 |
| `docker-compose.prod.yml` | 服务器生产部署 compose 文件 |
| `.env.prod.example` | 服务器 `.env` 示例，不包含真实密码 |
| `.ci-images.env.example` | CI 生成的镜像变量示例，便于本地检查 compose 配置 |
| `.dockerignore` | 减少 Docker build context，无关文件不进镜像构建上下文 |

## GitHub Secrets

在 GitHub 仓库中配置 `Settings -> Secrets and variables -> Actions -> Repository secrets`。

必填：

| Secret | 说明 |
| --- | --- |
| `SERVER_HOST` | 服务器 IP 或域名 |
| `SERVER_USER` | SSH 用户，例如 `root` |
| `SERVER_SSH_KEY` | SSH 私钥内容 |

可选：

| Secret | 默认值 | 说明 |
| --- | --- | --- |
| `SERVER_PORT` | `22` | SSH 端口 |
| `SERVER_DEPLOY_DIR` | `/opt/innotrack` | 服务器部署目录 |
| `GHCR_USERNAME` | 空 | 如果 GHCR 镜像是 private，填写 GitHub 用户名 |
| `GHCR_TOKEN` | 空 | 如果 GHCR 镜像是 private，填写有 `read:packages` 权限的 PAT |

说明：

- GitHub Actions 推送镜像到 GHCR 时使用内置 `GITHUB_TOKEN`，不需要额外配置 push token。
- 服务器拉取 GHCR private 镜像时需要 `GHCR_USERNAME` 和 `GHCR_TOKEN`。如果把 GHCR Package 设置为 public，可不配置这两个值。

## 服务器初始化

服务器需要先安装 Docker 和 Docker Compose 插件。

第一次部署前，在服务器创建部署目录和 `.env`：

```bash
mkdir -p /opt/innotrack
cd /opt/innotrack
cp .env.prod.example .env
```

如果服务器没有项目源码，就手动创建 `.env`，内容参考：

```bash
MYSQL_PASSWORD=your-mysql-password
REDIS_PASSWORD=your-redis-password
MQ_PASSWORD=your-rabbitmq-password
AGENT_SHARED_SECRET=your-agent-shared-secret
JAVA_OPTS=-Xms256m -Xmx512m -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=256m
```

注意：

- 不要把真实 `.env` 提交到 Git。
- 如果线上已经有旧数据库容器和 volume，切换到 `docker-compose.prod.yml` 前要确认 volume 名称和数据迁移策略。不同部署目录会导致 Compose 项目名不同，volume 名也可能不同。

## 部署流程

推送到 `main` 分支：

```bash
git push origin main
```

或者在 GitHub Actions 页面手动运行 `Build and Deploy InnoTrack`。

流水线会执行：

1. `mvn -B clean package -Dmaven.test.skip=true`
2. `npm ci && npm run build:prod`
3. 构建并推送：
   - `ghcr.io/<owner>/innotrack-app:<commit-sha>`
   - `ghcr.io/<owner>/innotrack-nginx:<commit-sha>`
   - 同时更新 `latest`
4. 上传 `docker-compose.prod.yml` 到服务器
5. 在服务器写入 `.ci-images.env`
6. 执行：

```bash
docker compose --env-file .env --env-file .ci-images.env -f docker-compose.prod.yml pull
docker compose --env-file .env --env-file .ci-images.env -f docker-compose.prod.yml up -d
docker image prune -f
```

## 验证命令

服务器上查看容器状态：

```bash
cd /opt/innotrack
docker compose --env-file .env --env-file .ci-images.env -f docker-compose.prod.yml ps
docker logs ruoyi-app --tail 100
docker logs ruoyi-nginx --tail 100
```

本机访问：

```bash
curl http://你的服务器IP/
curl http://你的服务器IP/prod-api/student/hall/list
```

## 回滚

每次构建都会生成 commit sha tag。需要回滚时，在服务器修改 `.ci-images.env`：

```bash
APP_IMAGE=ghcr.io/<owner>/innotrack-app:<old-commit-sha>
NGINX_IMAGE=ghcr.io/<owner>/innotrack-nginx:<old-commit-sha>
```

然后执行：

```bash
docker compose --env-file .env --env-file .ci-images.env -f docker-compose.prod.yml pull
docker compose --env-file .env --env-file .ci-images.env -f docker-compose.prod.yml up -d
```

## 当前取舍

- CI 暂时使用 `-Dmaven.test.skip=true`，优先保证能部署。后续测试稳定后应改为执行关键单元测试和后端编译测试。
- 前端镜像内置 dist，不再依赖服务器挂载 `./innotrack-ui/dist`。
- 服务器内存紧张，生产 compose 给 MySQL、Redis、RabbitMQ、App、Nginx 都加了内存上限。
- 这套 CI/CD 是单机部署，不是 Kubernetes，也不是高可用集群；它解决的是“可重复构建、可自动部署、可回滚”的工程化问题。
