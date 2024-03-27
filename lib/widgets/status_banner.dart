import 'package:flutter/material.dart';
import 'package:lapo_user/mainScreen/home_screen.dart';

class StatusBanner extends StatelessWidget 
{
  final bool? status;
  final String? orderStatus;

  StatusBanner({this.status, this.orderStatus});


  @override
  Widget build(BuildContext context) 
  {
    String? message;
    IconData? iconData;

    status! ? iconData = Icons.done : iconData = Icons.cancel;
    status! ? message = "Successful" : message = "Unsuccessful";


    return Container(
       decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                 Color.fromARGB(255, 206, 14, 14),
                 Colors.white,
                 
                ],
                begin: FractionalOffset(1.0, 0.8),
                end: FractionalOffset(1.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              )
            ),
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  orderStatus == "ended" 
                  ? "Food has been Delivered! $message" 
                  : "Order has been Placed! $message",
                style: const TextStyle(
                  color: Colors.white),
                ),
                const SizedBox(
                  width: 5,
                ),
                CircleAvatar(
                  radius: 8, 
                  backgroundColor: Colors.grey,
                  child: Center(
                    child: Icon(
                      iconData,
                      color: Colors.white,
                      size: 14,
                      
                    ),
                  ),
                ),
          ],
        ) ,
    );
  }
}