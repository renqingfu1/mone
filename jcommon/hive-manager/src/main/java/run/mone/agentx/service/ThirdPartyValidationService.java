package run.mone.agentx.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;
import run.mone.agentx.config.JwtConfig;
import run.mone.agentx.entity.User;

import java.time.Duration;
import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
public class ThirdPartyValidationService {
    
    private final JwtConfig jwtConfig;
    private final WebClient.Builder webClientBuilder;
    
    /**
     * 调用第三方接口校验token
     * @param token JWT token
     * @return 返回用户对象，如果校验失败返回null
     */
    public User validateToken(String token) {
        JwtConfig.ThirdParty thirdParty = jwtConfig.getThirdParty();
        
        // 如果未启用第三方校验或URL为空，返回null
        if (!thirdParty.isEnabled() || !StringUtils.hasText(thirdParty.getUrl())) {
            return null;
        }
        
        try {
            WebClient webClient = webClientBuilder.build();
            
            Mono<Map> response = webClient.post()
                    .uri(thirdParty.getUrl())
                    .header("Authorization", "Bearer " + token)
                    .cookie("sessionId", token)
                    .retrieve()
                    .bodyToMono(Map.class)
                    .timeout(Duration.ofMillis(thirdParty.getTimeout()));
            
            Map<String, Object> result = response.block();
            
            if (result != null && result.get("id") != null && (Integer) result.get("id") > 0) {
                // 从第三方接口返回的数据构建User对象
                return buildUserFromResponse(result);
            }
            
            log.warn("第三方接口校验失败，token: {}", token);
            return null;
            
        } catch (Exception e) {
            log.error("调用第三方接口校验token失败", e);
            return null;
        }
    }
    
    /**
     * 从第三方接口返回的数据构建User对象
     * @param response 第三方接口返回的数据
     * @return User对象
     */
    private User buildUserFromResponse(Map<String, Object> response) {
        try {
            User user = new User();
            
            // 基本信息
            user.setUsername((String) response.get("username"));
            user.setEmail((String) response.get("email"));
            user.setToken((String) response.get("token"));
            user.setInternalAccount((String) response.get("internalAccount"));
            
            // ID处理
            Object idObj = response.get("id");
            if (idObj != null) {
                if (idObj instanceof Number) {
                    user.setId(((Number) idObj).longValue());
                } else if (idObj instanceof String) {
                    try {
                        user.setId(Long.parseLong((String) idObj));
                    } catch (NumberFormatException e) {
                        log.warn("无法解析用户ID: {}", idObj);
                    }
                }
            }
            
            // 时间戳处理 - BaseEntity使用Long类型的时间戳
            Object ctimeObj = response.get("ctime");
            if (ctimeObj != null) {
                if (ctimeObj instanceof Number) {
                    user.setCtime(((Number) ctimeObj).longValue());
                } else if (ctimeObj instanceof String) {
                    try {
                        user.setCtime(Long.parseLong((String) ctimeObj));
                    } catch (NumberFormatException e) {
                        log.warn("无法解析创建时间戳: {}", ctimeObj);
                        user.setCtime(System.currentTimeMillis());
                    }
                }
            } else {
                user.setCtime(System.currentTimeMillis());
            }
            
            Object utimeObj = response.get("utime");
            if (utimeObj != null) {
                if (utimeObj instanceof Number) {
                    user.setUtime(((Number) utimeObj).longValue());
                } else if (utimeObj instanceof String) {
                    try {
                        user.setUtime(Long.parseLong((String) utimeObj));
                    } catch (NumberFormatException e) {
                        log.warn("无法解析更新时间戳: {}", utimeObj);
                        user.setUtime(System.currentTimeMillis());
                    }
                }
            } else {
                user.setUtime(System.currentTimeMillis());
            }
            
            // 状态字段处理
            Object stateObj = response.get("state");
            if (stateObj != null) {
                if (stateObj instanceof Number) {
                    user.setState(((Number) stateObj).intValue());
                } else if (stateObj instanceof String) {
                    try {
                        user.setState(Integer.parseInt((String) stateObj));
                    } catch (NumberFormatException e) {
                        log.warn("无法解析状态: {}", stateObj);
                        user.setState(1); // 默认状态为1（正常）
                    }
                }
            } else {
                user.setState(1); // 默认状态为1（正常）
            }
            
            log.info("成功构建用户对象: username={}, email={}, internalAccount={}", 
                user.getUsername(), user.getEmail(), user.getInternalAccount());
            return user;
            
        } catch (Exception e) {
            log.error("构建User对象失败", e);
            return null;
        }
    }
} 