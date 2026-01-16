package com.inveny.backend.controller;

import com.inveny.backend.service.StockService;
import com.inveny.backend.entity.Stock;
import com.inveny.backend.repository.StockRepository;
import java.util.List;
import lombok.Generated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping({"/api/stocks"})
public class StockController {
    private final StockService stockService;
    private final StockRepository stockRepository;

    @GetMapping
    public List getStocks() {
        return this.stockService.getAllStocks();
    }

    @PostMapping
    public Stock addStock(@RequestBody Stock stock) {
        return this.stockService.createStock(stock);
    }

    @PutMapping({"/{id}"})
    public Stock updateStock(@PathVariable Long id, @RequestBody Stock stock) {
        return this.stockService.updateStock(id, stock);
    }

    @DeleteMapping({"/{id}"})
    public void deleteStock(@PathVariable Long id) {
        this.stockService.deleteStock(id);
    }

    @Generated
    public StockController(final StockService stockService, final StockRepository stockRepository) {
        this.stockService = stockService;
        this.stockRepository = stockRepository;
    }
}
