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
  // 이름 수정을 위해 컨트롤러를 추가해요.
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    currentQuantity = widget.stock.quantity;
    nameController = TextEditingController(text: widget.stock.name);
  }

  // 1. 삭제를 정말 할 것인지 물어보는 팝업창이에요.
  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('재고 삭제'),
        content: Text('${widget.stock.name}을(를) 정말 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // 취소하면 창만 닫아요.
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
          // 3. 우측 상단에 삭제 아이콘을 달아줘요.
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
              // 이름을 수정할 수 있게 TextField로 바꿔보세요!
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
                    // 수정 시에는 이름과 수량을 함께 보내요.
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