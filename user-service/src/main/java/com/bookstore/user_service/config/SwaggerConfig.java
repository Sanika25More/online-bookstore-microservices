package com.bookstore.user_service.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.Contact;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class SwaggerConfig {

    @Bean
    public OpenAPI userServiceOpenAPI() {
        return new OpenAPI()
                .info(new Info()
                        .title("User Service API")
                        .description("RESTful API documentation for User Service in Online Bookstore Microservices")
                        .version("1.0.0")
                        .contact(new Contact()
                                .name("User Service Team")
                                .email("user-service@bookstore.com")));
    }
}

