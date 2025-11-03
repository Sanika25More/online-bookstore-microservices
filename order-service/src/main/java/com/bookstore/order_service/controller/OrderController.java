package com.bookstore.order_service.controller;

import com.bookstore.order_service.entity.Order;
import com.bookstore.order_service.service.OrderService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/orders")
@Tag(name = "Order Controller", description = "API endpoints for managing orders in the bookstore")
public class OrderController {

    private final OrderService orderService;

    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @Operation(summary = "Place a new order", description = "Create a new order for books in the bookstore")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Order placed successfully",
                    content = @Content(schema = @Schema(implementation = Order.class)))
    })
    @PostMapping
    public Order createOrder(@RequestBody Order order) {
        return orderService.placeOrder(order);
    }

    @Operation(summary = "Get all orders", description = "Retrieve a list of all orders")
    @ApiResponse(responseCode = "200", description = "List of all orders",
            content = @Content(schema = @Schema(implementation = Order.class)))
    @GetMapping
    public List<Order> getAllOrders() {
        return orderService.getAllOrders();
    }

    @Operation(summary = "Get order by ID", description = "Retrieve a specific order by its ID")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Order found",
                    content = @Content(schema = @Schema(implementation = Order.class))),
            @ApiResponse(responseCode = "404", description = "Order not found")
    })
    @GetMapping("/{id}")
    public Optional<Order> getOrderById(
            @Parameter(description = "Order ID", required = true) @PathVariable Long id) {
        return orderService.getOrderById(id);
    }

    @Operation(summary = "Get orders by user", description = "Retrieve all orders for a specific user")
    @ApiResponse(responseCode = "200", description = "List of user orders",
            content = @Content(schema = @Schema(implementation = Order.class)))
    @GetMapping("/user/{userId}")
    public List<Order> getOrdersByUser(
            @Parameter(description = "User ID", required = true) @PathVariable Long userId) {
        return orderService.getOrdersByUser(userId);
    }

    @Operation(summary = "Update order status", description = "Update the status of an existing order")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Order status updated successfully",
                    content = @Content(schema = @Schema(implementation = Order.class))),
            @ApiResponse(responseCode = "404", description = "Order not found")
    })
    @PutMapping("/{id}/status")
    public Order updateOrderStatus(
            @Parameter(description = "Order ID", required = true) @PathVariable Long id,
            @Parameter(description = "New order status", required = true) @RequestParam String status) {
        return orderService.updateOrderStatus(id, status);
    }

    @Operation(summary = "Cancel order", description = "Cancel/Delete an existing order")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Order cancelled successfully"),
            @ApiResponse(responseCode = "404", description = "Order not found")
    })
    @DeleteMapping("/{id}")
    public void deleteOrder(
            @Parameter(description = "Order ID", required = true) @PathVariable Long id) {
        orderService.deleteOrder(id);
    }
}
