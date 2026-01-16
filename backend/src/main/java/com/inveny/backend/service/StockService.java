package com.inveny.backend.service;

import com.inveny.backend.entity.Stock;
import com.inveny.backend.repository.StockRepository;
import java.util.List;
import lombok.Generated;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class StockService {
    private final StockRepository stockRepository;

    public List getAllStocks() {
        return this.stockRepository.findAll();
    }

    public Stock createStock(Stock stock) {
        return (Stock)this.stockRepository.save(stock);
    }

    @Transactional
    public Stock updateStock(Long id, Stock stockDetails) {
        Stock stock = (Stock)this.stockRepository.findById(id).orElseThrow(() -> {
            return new RuntimeException("재고를 찾을 수 없습니다. id: " + id);
        });
        stock.setName(stockDetails.getName());
        stock.setCategory(stockDetails.getCategory());
        stock.setQuantity(stockDetails.getQuantity());
        stock.setMemo(stockDetails.getMemo());
        return (Stock)this.stockRepository.save(stock);
    }

    @Transactional
    public void deleteStock(Long id) {
        if (!this.stockRepository.existsById(id)) {
            throw new RuntimeException("삭제할 재고가 없습니다. id: " + id);
        } else {
            this.stockRepository.deleteById(id);
        }
    }

    @Generated
    public StockService(final StockRepository stockRepository) {
        this.stockRepository = stockRepository;
    }
}
