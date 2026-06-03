# 第一阶段：构建前端
FROM node:18-alpine AS frontend
WORKDIR /app/ruoyi-ui
COPY ruoyi-ui/package*.json ./
RUN npm install
COPY ruoyi-ui/ ./
RUN npm run build

# 第二阶段：构建后端
FROM maven:3.8-openjdk-8 AS backend
WORKDIR /app
COPY pom.xml ./
COPY ruoyi-common ./ruoyi-common
COPY ruoyi-framework ./ruoyi-framework
COPY ruoyi-system ./ruoyi-system
COPY ruoyi-quartz ./ruoyi-quartz
COPY ruoyi-generator ./ruoyi-generator
COPY ruoyi-admin ./ruoyi-admin
COPY --from=frontend /app/ruoyi-ui/dist ./ruoyi-admin/src/main/resources/static
RUN mvn clean package -DskipTests -pl ruoyi-admin -am

# 第三阶段：运行
FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=backend /app/ruoyi-admin/target/ruoyi-admin-*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
