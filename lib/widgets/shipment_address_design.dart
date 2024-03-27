import 'package:flutter/material.dart';
import 'package:lapo_user/mainScreen/home_screen.dart';
import 'package:lapo_user/models/address.dart';
import 'package:lapo_user/splashScreen/splash_screen.dart';

class ShipmentAddressDesign extends StatelessWidget 
{

  final Address? model;

  ShipmentAddressDesign({this.model});



  @override
  Widget build(BuildContext context) 
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "Delivery Details:",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 6,
        ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 5),
            width: MediaQuery.of(context).size.width,
            child: Table(
              children: [
                TableRow(
                  children: [
                    const Text(
                      "Name",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(model!.name!),
                  ],
                ),
                TableRow(
                  children: [
                    const Text(
                      "Mobile Number",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(model!.phoneNumber!),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              model!.fullAddress!,
              textAlign: TextAlign.justify,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: InkWell(
                onTap: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
                },
                child: Container(
                    decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                          Color.fromARGB(255, 206, 14, 14),
                      Colors.amber,
                      
                      ],
                      begin: FractionalOffset(1.0, 0.5),
                      end: FractionalOffset(0.0, 0.5),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    )
                  ),
                  width: MediaQuery.of(context).size.width - 40,
                  height: 50,
                  child: const Center(
                    child: Text(
                      "Go to Home",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
          ),

      ],
    );
  }
}