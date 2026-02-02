package com.inveny.backend.controller;


import com.inveny.backend.entity.User;
import com.inveny.backend.service.UserService;
import lombok.Generated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/users")
public class UserController {
    private final UserService userService;

    @Generated
    public UserController(final UserService userService) {
        this.userService = userService;
    }

    // 로그인
    @PostMapping("/login")
    public User login(@RequestBody User user) {
        return userService.login(user.getLoginId(), user.getPassword());
    }

    // 회원가입
    @PostMapping("/register")
    public User register(@RequestBody User user) {
        return userService.register(user.getLoginId(), user.getPassword());
    }
}
