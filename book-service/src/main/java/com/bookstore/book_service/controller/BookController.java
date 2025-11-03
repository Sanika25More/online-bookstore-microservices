package com.bookstore.book_service.controller;

import com.bookstore.book_service.entity.Book;
import com.bookstore.book_service.service.BookService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/books")
@Tag(name = "Book Controller", description = "API endpoints for managing books in the bookstore")
public class BookController {

    @Autowired
    private BookService bookService;

    @Operation(summary = "Reduce book stock", description = "Reduce the stock quantity of a book by a specified amount")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Stock reduced successfully"),
            @ApiResponse(responseCode = "404", description = "Book not found")
    })
    @PutMapping("/{id}/reduce-stock")
    public Book reduceStock(
            @Parameter(description = "Book ID", required = true) @PathVariable Long id,
            @Parameter(description = "Quantity to reduce", required = true) @RequestParam int qty) {
        return bookService.reduceStock(id, qty);
    }

    @Operation(summary = "Create a new book", description = "Add a new book to the bookstore catalog")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Book created successfully",
                    content = @Content(schema = @Schema(implementation = Book.class)))
    })
    @PostMapping
    public Book createBook(@RequestBody Book book) {
        return bookService.createBook(book);
    }

    @Operation(summary = "Get all books", description = "Retrieve a list of all books in the bookstore")
    @ApiResponse(responseCode = "200", description = "List of all books",
            content = @Content(schema = @Schema(implementation = Book.class)))
    @GetMapping
    public List<Book> getAllBooks() {
        return bookService.getAllBooks();
    }

    @Operation(summary = "Get book by ID", description = "Retrieve a specific book by its ID")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Book found",
                    content = @Content(schema = @Schema(implementation = Book.class))),
            @ApiResponse(responseCode = "404", description = "Book not found")
    })
    @GetMapping("/{id}")
    public ResponseEntity<Book> getBookById(
            @Parameter(description = "Book ID", required = true) @PathVariable Long id) {
        return bookService.getBookById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @Operation(summary = "Update book", description = "Update an existing book's information")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Book updated successfully",
                    content = @Content(schema = @Schema(implementation = Book.class))),
            @ApiResponse(responseCode = "404", description = "Book not found")
    })
    @PutMapping("/{id}")
    public Book updateBook(
            @Parameter(description = "Book ID", required = true) @PathVariable Long id,
            @RequestBody Book book) {
        return bookService.updateBook(id, book);
    }

    @Operation(summary = "Delete book", description = "Delete a book from the bookstore catalog")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "Book deleted successfully"),
            @ApiResponse(responseCode = "404", description = "Book not found")
    })
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteBook(
            @Parameter(description = "Book ID", required = true) @PathVariable Long id) {
        bookService.deleteBook(id);
        return ResponseEntity.noContent().build();
    }
}
