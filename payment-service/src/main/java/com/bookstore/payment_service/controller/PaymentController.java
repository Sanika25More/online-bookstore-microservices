package com.bookstore.payment_service.controller;

import com.bookstore.payment_service.entity.Payment;
import com.bookstore.payment_service.service.PaymentService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/payments")
@Tag(name = "Payment Controller", description = "API endpoints for managing payments in the bookstore")
public class PaymentController {

    private final PaymentService paymentService;

    public PaymentController(PaymentService paymentService) {
        this.paymentService = paymentService;
    }

    @Operation(summary = "Make a payment", description = "Process a new payment for an order")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Payment processed successfully",
                    content = @Content(schema = @Schema(implementation = Payment.class)))
    })
    @PostMapping
    public Payment makePayment(@RequestBody Payment payment) {
        return paymentService.makePayment(payment);
    }

    @Operation(summary = "Get payment by ID", description = "Retrieve a specific payment by its ID")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Payment found",
                    content = @Content(schema = @Schema(implementation = Payment.class))),
            @ApiResponse(responseCode = "404", description = "Payment not found")
    })
    @GetMapping("/{id}")
    public Payment getPayment(
            @Parameter(description = "Payment ID", required = true) @PathVariable Long id) {
        return paymentService.getPayment(id);
    }

    @Operation(summary = "Get all payments", description = "Retrieve a list of all payments")
    @ApiResponse(responseCode = "200", description = "List of all payments",
            content = @Content(schema = @Schema(implementation = Payment.class)))
    @GetMapping
    public List<Payment> getAllPayments() {
        return paymentService.getAllPayments();
    }

    @Operation(summary = "Update payment", description = "Update an existing payment's information")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Payment updated successfully",
                    content = @Content(schema = @Schema(implementation = Payment.class))),
            @ApiResponse(responseCode = "404", description = "Payment not found")
    })
    @PutMapping("/{id}")
    public Payment updatePayment(
            @Parameter(description = "Payment ID", required = true) @PathVariable Long id,
            @RequestBody Payment payment) {
        Payment existing = paymentService.getPayment(id);
        if (existing != null) {
            existing.setAmount(payment.getAmount());
            existing.setMethod(payment.getMethod());
            existing.setStatus(payment.getStatus());
            return paymentService.makePayment(existing); // save updated payment
        }
        return null;
    }

    @Operation(summary = "Refund payment", description = "Process a refund for an existing payment")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Payment refunded successfully",
                    content = @Content(schema = @Schema(implementation = Payment.class))),
            @ApiResponse(responseCode = "404", description = "Payment not found")
    })
    @PutMapping("/{id}/refund")
    public Payment refundPayment(
            @Parameter(description = "Payment ID", required = true) @PathVariable Long id) {
        return paymentService.refundPayment(id);
    }
}
