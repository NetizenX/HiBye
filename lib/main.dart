import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/main_screen.dart';
import 'screens/payment_screen.dart';
import 'screens/login_screen.dart';
import 'model/data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'model/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Data(),
        ),
        ChangeNotifierProvider(
          create: (context) => User(),
        ),
      ],
      child: MaterialApp(
        routes: {
          'login_screen': (context) => LoginScreen(),
          'main_screen': (context) => MainScreen(),
          'payment_screen': (context) => PaymentScreen(),
        },
        initialRoute: 'login_screen',
        debugShowCheckedModeBanner: false,
        title: 'HiBye App',
        home: MainScreen(),
      ),
    );
  }
}
