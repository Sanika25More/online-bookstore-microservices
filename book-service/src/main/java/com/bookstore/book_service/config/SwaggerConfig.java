package com.bookstore.book_service.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.Contact;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class SwaggerConfig {

    @Bean
    public OpenAPI bookServiceOpenAPI() {
        return new OpenAPI()
                .info(new Info()
                        .title("Book Service API")
                        .description("RESTful API documentation for Book Service in Online Bookstore Microservices")
                        .version("1.0.0")
                        .contact(new Contact()
                                .name("Book Service Team")
                                .email("book-service@bookstore.com")));
    }
}

