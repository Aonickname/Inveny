package com.inveny.backend.service;

import com.inveny.backend.entity.User;
import com.inveny.backend.repository.UserRepository;
import lombok.Generated;
import org.springframework.stereotype.Service;

@Service
public class UserService {
    private final UserRepository userRepository;

    @Generated
    public UserService(final UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    //로그인
    public User login(String loginId, String password) {

        java.util.Optional<User> userBox = userRepository.findByLoginId(loginId);

        System.out.println("로그인 시도 아이디: " + loginId);
        System.out.println("로그인 시도 비번: " + password);

        if (userBox.isEmpty()) {
            throw new RuntimeException("아이디가 존재하지 않습니다.");
        }

        User user = userBox.get();

        if (!user.getPassword().equals(password)) {
            throw new RuntimeException("비밀번호가 일치하지 않습니다.");
        }

        return user;
    }

    //회원가입
    public User register(String loginId, String password) {

        java.util.Optional<User> userBox = userRepository.findByLoginId(loginId);

        if (!userBox.isEmpty()) {
            throw new RuntimeException("이미 존재하는 아이디입니다.");
        }

        User user = new User();
        user.setLoginId(loginId);
        user.setPassword(password);

        return userRepository.save(user);
    }

}
