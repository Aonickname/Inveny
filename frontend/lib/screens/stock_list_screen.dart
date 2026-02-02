import 'package:flutter/material.dart';
import '../models/stock.dart'; 
import '../services/stock_service.dart'; 
import '../widgets/stock_card.dart'; 
import 'stock_detail_screen.dart'; 
import 'stock_add_screen.dart'; 
import 'login_screen.dart';

enum SortOption { name, quantityAsc, quantityDesc }

class StockListScreen extends StatefulWidget {
  const StockListScreen({super.key});

  @override
  State<StockListScreen> createState() => _StockListScreenState();
}

class _StockListScreenState extends State<StockListScreen> {
  final StockService stockService = StockService();
  
  SortOption _currentSort = SortOption.name;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
          padding: EdgeInsets.zero,

          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.orange),
              child: Text('Inveny 메뉴', style: TextStyle(color: Colors.white, fontSize: 20)),
            ),

            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('내 정보'),
              onTap: () {
                // 정보 화면 이동 로직
              },
            ),

            ListTile(
              leading: const Icon(Icons.assignment),
              title: const Text('게시판'),
              onTap: () {
                // 게시판 이동 로직
              },
            ),

            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('로그아웃', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
            )
          ]
        ),
        ),

        // 필터링 버튼
        appBar: AppBar(
          title: const Text('재고 목록 보기'),
          actions: [
            PopupMenuButton<SortOption>(
              icon: const Icon(Icons.sort),
              onSelected: (SortOption result) {
                setState(() {
                  _currentSort = result; 
                });
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<SortOption>>[
                const PopupMenuItem<SortOption>(
                  value: SortOption.name,
                  child: Text('가나다순 (이름)'),
                ),
                const PopupMenuItem<SortOption>(
                  value: SortOption.quantityAsc,
                  child: Text('남은순 (적은순)'),
                ),
                const PopupMenuItem<SortOption>(
                  value: SortOption.quantityDesc,
                  child: Text('남은순 (많은순)'),
                ),
              ],
            ),
          ],
          bottom: const TabBar(
            tabs: [Tab(text: '주방 재고'), Tab(text: '홀 재고'), Tab(text: '기타 비품',)],
            indicatorColor: Colors.orange,
            labelColor: Colors.orange,
          ),
        ),
        body: FutureBuilder<List<Stock>>(
          future: stockService.fetchStocks(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('에러 발생: ${snapshot.error}'));
            }

            final allStocks = snapshot.data ?? [];

            return TabBarView(
              children: [
                // 1. 주방 재고
                _buildFilteredList(allStocks.where((s) => s.location == '주방').toList()),
                // 2. 홀 재고
                _buildFilteredList(allStocks.where((s) => s.location == '홀').toList()),
                // 3. 비품
                _buildFilteredList(allStocks.where((s) => s.location == '비품').toList()), 
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (context) => const StockAddScreen()));
            setState(() {}); 
          },
          label: const Text('재고 추가'),
          icon: const Icon(Icons.add),
          backgroundColor: Colors.orange,
        ),
      ),
    );
  }

  Widget _buildFilteredList(List<Stock> stocks) {
    if (stocks.isEmpty) return const Center(child: Text('재고가 없습니다.'));

    if (_currentSort == SortOption.name) {
      stocks.sort((a, b) => a.name.compareTo(b.name)); // 가나다순
    } else if (_currentSort == SortOption.quantityAsc) {
      stocks.sort((a, b) => a.quantity.compareTo(b.quantity)); // 적은순
    } else if (_currentSort == SortOption.quantityDesc) {
      stocks.sort((a, b) => b.quantity.compareTo(a.quantity)); // 많은순
    }

    return ListView.builder(
      itemCount: stocks.length,
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemBuilder: (context, index) {
        final stock = stocks[index];
        return InkWell(
          onTap: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (context) => StockDetailScreen(stock: stock)));
            setState(() {});
          },
          child: StockCard(stock: stock),
        );
      },
    );
  }
}