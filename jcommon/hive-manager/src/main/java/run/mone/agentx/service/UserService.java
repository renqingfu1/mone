package run.mone.agentx.service;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import lombok.extern.slf4j.Slf4j;
import lombok.RequiredArgsConstructor;
import reactor.core.publisher.Mono;
import reactor.core.publisher.Flux;
import run.mone.agentx.dto.UserDTO;
import run.mone.agentx.entity.User;
import run.mone.agentx.repository.UserRepository;

import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;
    private final ThirdPartyValidationService thirdPartyValidationService;

    public Mono<User> createUser(User user) {
        log.info("开始创建用户: {}", user.getUsername());
        
        // 直接保存用户，不做重复检查
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setCtime(System.currentTimeMillis());
        user.setUtime(System.currentTimeMillis());
        user.setState(1);
        
        log.info("准备保存用户到数据库: {}", user);
        
        return Mono.just(user)
                .flatMap(userToSave -> {
                    log.info("执行保存操作");
                    return userRepository.save(userToSave);
                })
                .doOnSuccess(savedUser -> log.info("用户保存成功: {}", savedUser))
                .doOnError(error -> log.error("保存用户时发生错误: {}", error.getMessage(), error));
    }

    public Mono<User> findByUsername(String username) {
        return userRepository.findByUsername(username);
    }
    
    public Mono<User> authenticate(String username, String password) {
        return userRepository.findByUsername(username)
                .filter(user -> passwordEncoder.matches(password, user.getPassword()));
    }

    public Flux<User> findAllUsers() {
        return userRepository.findAll();
    }

    public Mono<String> createToken(User user) {
        return findByUsername(user.getUsername())
                .flatMap(existingUser -> {
                    String token = UUID.randomUUID().toString().replace("-", "");
                    existingUser.setToken(token);
                    return userRepository.save(existingUser)
                            .thenReturn(token);
                })
                .doOnSuccess(t -> log.info("为用户 {} 创建token成功", user.getUsername()))
                .doOnError(error -> log.error("创建token失败: {}", error.getMessage(), error));
    }

    public Mono<String> getCurrentUserToken(User user) {
        return findByUsername(user.getUsername())
                .map(userFound -> {
                    String token = userFound.getToken();
                    return token != null ? token : "";
                })
                .doOnError(error -> log.error("获取用户token失败: {}", error.getMessage(), error));
    }

    public Mono<Boolean> verifyToken(String token) {
        // 如果token为null，直接返回false
        if (token == null || token.trim().isEmpty()) {
            return Mono.just(false);
        }
        
        // 首先尝试第三方接口校验
        return Mono.fromSupplier(() -> thirdPartyValidationService.validateToken(token))
                .flatMap(thirdPartyUser -> {
                    if (thirdPartyUser != null) {
                        // 第三方校验成功，检查用户状态
                        if (thirdPartyUser.getState() != null && thirdPartyUser.getState() != 1) {
                            log.warn("第三方校验用户状态异常，token验证失败: {}", thirdPartyUser.getUsername());
                            return Mono.just(false);
                        }
                        log.info("第三方token验证成功: {}", thirdPartyUser.getUsername());
                        return Mono.just(true);
                    }
                    
                    // 第三方校验失败或未配置，使用原有的数据库查询逻辑
                    log.debug("第三方校验未配置或失败，使用本地数据库校验");
                    return userRepository.findByToken(token)
                            .map(user -> {
                                // 检查用户状态是否正常
                                if (user.getState() != 1) {
                                    log.warn("用户状态异常，token验证失败: {}", user.getUsername());
                                    return false;
                                }
                                log.info("本地token验证成功: {}", user.getUsername());
                                return true;
                            })
                            .defaultIfEmpty(false);
                })
                .doOnError(error -> log.error("验证token时发生错误: {}", error.getMessage(), error))
                .onErrorReturn(false);
    }

    public Mono<UserDTO> getUserInfo(User user) {
        return findByUsername(user.getUsername())
                .map(UserDTO::fromUser)
                .doOnSuccess(info -> log.info("获取用户信息成功: {}", user.getUsername()))
                .doOnError(error -> log.error("获取用户信息失败: {}", error.getMessage(), error));
    }

    public Mono<String> bindInternalAccount(User user, String internalAccount) {
        return findByUsername(user.getUsername())
                .flatMap(existingUser -> {
                    existingUser.setInternalAccount(internalAccount);
                    return userRepository.save(existingUser)
                            .thenReturn(internalAccount);
                })
                .doOnSuccess(t -> log.info("为用户 {} 绑定内部账号成功", user.getUsername()))
                .doOnError(error -> log.error("绑定内部账号失败: {}", error.getMessage(), error));
    }

    public Mono<User> findByToken(String token) {
        return userRepository.findByToken(token)
                .doOnError(error -> log.error("根据token查找用户时发生错误: {}", error.getMessage(), error));
    }
}