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

      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/stockList': (context) => const StockListScreen(),
      },

      title: 'Inveny 재고관리',

      theme: ThemeData(

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange, 
          foregroundColor: Colors.white,  
          minimumSize: const Size(double.infinity, 50), 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          textStyle: const TextStyle(
            fontSize: 18,  
            fontWeight: FontWeight.bold, 
          ),
          elevation: 2,
        ),
      ),

        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.white,

        popupMenuTheme: const PopupMenuThemeData(
          color: Colors.white,
        ),

        menuTheme: const MenuThemeData(
          style: MenuStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.white),
          )
        ),

        canvasColor: Colors.white,

        inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey), 
        ),
        // 클릭 후 밑줄 색
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.orange, width: 2.0),
        ),
        // 라벨(글자) 색
        floatingLabelStyle: TextStyle(color: Colors.orange),
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        useMaterial3: true,
      ),
    );
  }
}