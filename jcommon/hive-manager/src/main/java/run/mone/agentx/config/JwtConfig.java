package run.mone.agentx.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
@ConfigurationProperties(prefix = "jwt")
public class JwtConfig {
    
    private long expiration = 86400000L; // 24 hours in milliseconds
    private ThirdParty thirdParty = new ThirdParty();
    
    @Data
    public static class ThirdParty {
        private boolean enabled = false;
        private String url;
        private int timeout = 5000;
    }
} 