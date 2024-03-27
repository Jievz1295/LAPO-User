import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lapo_user/assistantMethod/address_changer.dart';
import 'package:lapo_user/assistantMethod/cart_item_counter.dart';
import 'package:lapo_user/assistantMethod/total_amount.dart';
import 'package:lapo_user/global/global.dart';
import 'package:lapo_user/splashScreen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future <void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  sharedPreferences =  await SharedPreferences.getInstance();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c)=> CartItemCounter()),
        ChangeNotifierProvider(create: (c)=> TotalAmount()),
        ChangeNotifierProvider(create: (c)=> AddressChanger()),
      ],
      child: MaterialApp(
        title: 'User App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const MySplashScreen(),
      ),
    );
  }
}