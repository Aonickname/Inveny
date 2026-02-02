import 'package:flutter/material.dart';
import 'screens/stock_list_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'screens/login_screen.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  runApp(const InvenyApp());
}

class InvenyApp extends StatelessWidget {
  const InvenyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      initialRoute: '/stockList',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/stockList': (context) => const StockListScreen(),
      },

      title: 'Inveny 재고관리',

      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        useMaterial3: true,
      ),

      // home: const LoginScreen(), 
      // home: const StockListScreen(), 
    );
  }
}