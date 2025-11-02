package com.bookstore.order_service.client;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;

@FeignClient(name = "book-service")
public interface BookClient {

    @PutMapping("/books/{id}/reduce-stock")
    void reduceStock(@PathVariable("id") Long bookId, @RequestParam("qty") int quantity);

    @GetMapping("/books/{id}")
    BookResponse getBookById(@PathVariable("id") Long id);
}
