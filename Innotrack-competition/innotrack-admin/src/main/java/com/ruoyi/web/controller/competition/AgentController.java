package com.ruoyi.web.controller.competition;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.utils.SecurityUtils;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "AI 助手")
@RestController
@RequestMapping("/student/agent")
public class AgentController extends BaseController {

    @Value("${agent.python.url:http://localhost:8500}")
    private String agentUrl;

    @Value("${agent.shared-secret}")
    private String sharedSecret;

    private final ObjectMapper objectMapper = new ObjectMapper();

    @Operation(summary = "AI 对话（SSE 流式）")
    @PostMapping("/chat")
    public void chat(@RequestBody Map<String, Object> request, HttpServletResponse response) throws IOException {
        response.setContentType("text/event-stream");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Cache-Control", "no-cache");
        response.setHeader("Connection", "keep-alive");
        response.setHeader("X-Accel-Buffering", "no");

        Long userId = SecurityUtils.getUserId();

        Map<String, Object> agentRequest = new HashMap<>();
        agentRequest.put("message", request.getOrDefault("message", ""));
        agentRequest.put("stream", true);
        agentRequest.put("user_id", userId);
        agentRequest.put("session_id", request.getOrDefault("session_id", ""));

        byte[] body = objectMapper.writeValueAsBytes(agentRequest);

        HttpURLConnection conn = null;
        try {
            URL url = new URL(agentUrl + "/api/agent/chat");
            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setRequestProperty("X-Agent-Key", sharedSecret);
            conn.setConnectTimeout(30000);
            conn.setReadTimeout(300000);

            try (OutputStream os = conn.getOutputStream()) {
                os.write(body);
                os.flush();
            }

            int status = conn.getResponseCode();
            if (status != 200) {
                response.setStatus(500);
                response.getWriter().write("data: {\"event\":\"error\",\"data\":{\"error\":\"Agent service error: " + status + "\"}}\n\n");
                response.getWriter().flush();
                return;
            }

            try (InputStream is = conn.getInputStream();
                 OutputStream out = response.getOutputStream()) {
                byte[] buf = new byte[4096];
                int n;
                while ((n = is.read(buf)) != -1) {
                    out.write(buf, 0, n);
                    out.flush();
                }
            }
        } catch (Exception e) {
            response.setStatus(200);
            response.getWriter().write("data: {\"event\":\"error\",\"data\":{\"error\":\"Agent 服务未启动: " + e.getMessage() + "\"}}\n\n");
            response.getWriter().flush();
        } finally {
            if (conn != null) {
                conn.disconnect();
            }
        }
    }
}
