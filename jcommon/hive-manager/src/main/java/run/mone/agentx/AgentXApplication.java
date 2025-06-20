package run.mone.agentx;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.scheduling.annotation.EnableScheduling;
import run.mone.agentx.config.JwtConfig;

@SpringBootApplication
@EnableScheduling
@EnableConfigurationProperties(JwtConfig.class)
public class AgentXApplication {
    public static void main(String[] args) {
        SpringApplication.run(AgentXApplication.class, args);
    }
}