package com.bookstore.payment_service.repository;

import com.bookstore.payment_service.entity.Payment;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface PaymentRepository extends JpaRepository<Payment, Long> {

    // Find all payments related to a specific order
    List<Payment> findByOrderId(Long orderId);
}
