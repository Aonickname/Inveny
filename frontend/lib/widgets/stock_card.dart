import 'package:flutter/material.dart';
import '../models/stock.dart';

class StockCard extends StatelessWidget {
  final Stock stock;

  const StockCard({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    return Container(
      // 카드 사이의 간격을 조절해요.
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      // 내부 여백을 주어 답답하지 않게 만들어요.
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white, // 전체 배경은 깨끗한 하얀색!
        borderRadius: BorderRadius.circular(15), // 모서리를 부드럽게 깎아요.
        // 아주 연한 회색 선으로 테두리를 그려 깔끔함을 더해요.
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 왼쪽: 이름과 카테고리 정보
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stock.name, // 재고 이름 (예: 면, 대파)
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                stock.category ?? '기본 재료', 
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          // 오른쪽: 주황색 포인트 수량 태그
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.orange.shade50, // 연한 주황색 배경 포인트
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${stock.quantity} ${stock.unit} 남음', // 수량 정보
              style: const TextStyle(
                color: Colors.orange, // 진한 주황색 글씨 포인트
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}