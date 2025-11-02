package com.bookstore.order_service.client;

import com.bookstore.order_service.dto.PaymentRequest;
import com.bookstore.order_service.dto.PaymentResponse;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;

@FeignClient(name = "payment-service")
public interface PaymentClient {

    @PostMapping("/payments")
    PaymentResponse makePayment(PaymentRequest paymentRequest);
}
