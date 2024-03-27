import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lapo_user/authentication/auth_screen.dart';
import 'package:lapo_user/global/global.dart';
import 'package:lapo_user/mainScreen/home_screen.dart';


class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MySplashScreen> 
{
  startTimer()  
  {

    Timer(const Duration(seconds: 4), () async 
    {
        //if seller is already logged in   
         if(firebaseAuth.currentUser != null)
         {
            Navigator.push(context, MaterialPageRoute(builder: (c) => const HomeScreen()));
         }
         // if the seller not logged in
         else
         {
            Navigator.push(context, MaterialPageRoute(builder: (c) => const AuthScreen()));
         }
    });
  }

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.red,
                Colors.grey,
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("images/splash.png"),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Text(
                    "The Great Chosen For Delivery",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontFamily: "TrainOne",
                      fontSize: 20,
                      letterSpacing: 3,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
