import 'package:flutter/material.dart';
import '../models/stock.dart';
import '../services/stock_service.dart';

class StockDetailScreen extends StatefulWidget {
  final Stock stock;
  const StockDetailScreen({super.key, required this.stock});

  @override
  State<StockDetailScreen> createState() => _StockDetailScreenState();
}

class _StockDetailScreenState extends State<StockDetailScreen> {
  late int currentQuantity;
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    currentQuantity = widget.stock.quantity;
    nameController = TextEditingController(text: widget.stock.name);
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('재고 삭제'),
        content: Text('${widget.stock.name}을(를) 정말 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () async {
              try {
                await StockService().deleteStock(widget.stock.id ?? 0);
                
                if (!context.mounted) return; //

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('삭제되었습니다.')),
                );
                Navigator.pop(context); // 팝업 닫기
                Navigator.pop(context); // 상세 화면 닫기
              } catch (e) {
                debugPrint("삭제 에러: $e");
              }
            },
            child: const Text('삭제', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('재고 상세 관리'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: _showDeleteDialog,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: nameController,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(labelText: '물건 이름'),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '현재 수량: $currentQuantity ${widget.stock.unit}',
                style: const TextStyle(fontSize: 20, color: Colors.grey),
              ),
              const SizedBox(height: 40),
              
              // 수량 조절 버튼 (기존 유지)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle, size: 50, color: Colors.orange),
                    onPressed: () => setState(() { if (currentQuantity > 0) currentQuantity--; }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text('$currentQuantity', style: const TextStyle(fontSize: 45)),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle, size: 50, color: Colors.orange),
                    onPressed: () => setState(() => currentQuantity++),
                  ),
                ],
              ),
              const SizedBox(height: 50),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () async {
                  try {
                    await StockService().updateStock(
                      widget.stock.id ?? 0, 
                      nameController.text, 
                      widget.stock.category ?? '기타', 
                      currentQuantity
                    );
                    
                    if (!context.mounted) return; //
                    
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('수정되었습니다.')));
                    Navigator.pop(context);
                  } catch (e) {
                    debugPrint("수정 에러: $e");
                  }
                },
                child: const Text('변경 사항 저장하기', style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}