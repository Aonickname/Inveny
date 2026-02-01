import 'package:flutter/material.dart';
import '../services/stock_service.dart';

class StockAddScreen extends StatefulWidget {
  const StockAddScreen({super.key});

  @override
  State<StockAddScreen> createState() => _StockAddScreenState();
}

class _StockAddScreenState extends State<StockAddScreen> {
  final nameController = TextEditingController();
  final quantityController = TextEditingController();
  final memoController = TextEditingController();
  
  final customCategoryController = TextEditingController();
  final customUnitController = TextEditingController();

  String? selectedCategory;
  String? selectedUnit;
  String? selectedLocation;

  final List<String> categories = ['채소류', '기본 재료', '토핑', '소스', '음료', '기타'];
  final List<String> units = ['박스', '단', '개', '기타']; 
  final List<String> locations = ['주방', '홀', '비품'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('새 재고 등록')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: nameController, 
                decoration: const InputDecoration(labelText: '재고 이름 (예: 대파)')
              ),
              const SizedBox(height: 20),

              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: '카테고리 선택'),
                initialValue: selectedCategory,
                items: categories.map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
                onChanged: (val) => setState(() => selectedCategory = val),
              ),
              if (selectedCategory == '기타') ...[
                const SizedBox(height: 10),
                TextField(
                  controller: customCategoryController,
                  decoration: const InputDecoration(labelText: '카테고리 직접 입력', hintText: '예: 소모품'),
                ),
              ],
              const SizedBox(height: 20),

              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: '보관 구역 (주방/홀/비품)'),
                initialValue: selectedLocation,
                items: locations.map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
                onChanged: (val) => setState(() => selectedLocation = val),
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: quantityController,
                      decoration: const InputDecoration(labelText: '수량'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(labelText: '단위'),
                          initialValue: selectedUnit, 
                          items: units.map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
                          onChanged: (val) => setState(() => selectedUnit = val),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (selectedUnit == '기타') ...[
                const SizedBox(height: 10),
                TextField(
                  controller: customUnitController,
                  decoration: const InputDecoration(labelText: '단위 직접 입력', hintText: '예: 봉지'),
                ),
              ],
              const SizedBox(height: 20),

              TextField(
                controller: memoController, 
                decoration: const InputDecoration(labelText: '메모 (선택사항)')
              ),
              const SizedBox(height: 40),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, 
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                ),
                onPressed: () async {
                  if (nameController.text.isEmpty || selectedCategory == null || selectedUnit == null || selectedLocation == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('모든 필수 정보를 입력해주세요.')));
                    return;
                  }

                  String finalCategory = (selectedCategory == '기타') ? customCategoryController.text : selectedCategory!;
                  String finalUnit = (selectedUnit == '기타') ? customUnitController.text : selectedUnit!;

                  await StockService().createStock(
                    nameController.text,
                    int.parse(quantityController.text),
                    finalUnit, 
                    finalCategory, 
                    selectedLocation!,
                    memoController.text,
                  );

                  if (!context.mounted) return;
                  Navigator.pop(context);
                },
                child: const Text('등록하기', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}