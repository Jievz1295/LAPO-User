import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lapo_user/assistantMethod/assistant_methods.dart';
import 'package:lapo_user/global/global.dart';
import 'package:lapo_user/mainScreen/home_screen.dart';

class PlacedOrderScreen extends StatefulWidget 
{
  String? addressID;
  double? totalAmount;
  String? sellerUID;

  PlacedOrderScreen({this.sellerUID, this.totalAmount, this.addressID});


  @override
  State<PlacedOrderScreen> createState() => _PlacedOrderScreenState();
}

class _PlacedOrderScreenState extends State<PlacedOrderScreen> 
{
  String orderId = DateTime.now().millisecondsSinceEpoch.toString();

  addOrderDetails()
  {
    writeOrderDetailsForUser({
      "addressID": widget.addressID,
      "totalAmount": widget.totalAmount,
      "orderBy": sharedPreferences!.getString("uid"),
      "productIDs": sharedPreferences!.getStringList("userCart"),
      "paymentDetails": "Cash On Delivery(COD)",
      "orderTime": orderId,
      "isSuccess": true,
      "sellerUID": widget.sellerUID,
      "riderUID": "",
      "status": "normal",
      "orderId": orderId,
    });

    writeOrderDetailsForSeller({
      "addressID": widget.addressID,
      "totalAmount": widget.totalAmount,
      "orderBy": sharedPreferences!.getString("uid"),
      "productIDs": sharedPreferences!.getStringList("userCart"),
      "paymentDetails": "Cash On Delivery(COD)",
      "orderTime": orderId,
      "isSuccess": true,
      "sellerUID": widget.sellerUID,
      "riderUID": "",
      "status": "normal",
      "orderId": orderId,
    }).whenComplete((){
      clearCartNow(context);
      setState(() {
        orderId="";
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomeScreen()));
        Fluttertoast.showToast(msg: "Congratulations, Order has been placed successfully");
      });
    });
  }

  Future writeOrderDetailsForUser(Map<String, dynamic> data) async
  {
    await FirebaseFirestore.instance
    .collection("users")
    .doc(sharedPreferences!.getString("uid"))
    .collection("orders")
    .doc(orderId)
    .set(data);
  }

    Future writeOrderDetailsForSeller(Map<String, dynamic> data) async
  {
    await FirebaseFirestore.instance
    .collection("orders")
    .doc(orderId)
    .set(data);
  }

  @override
  Widget build(BuildContext context) 
  {
    return Material(
      child: Container(
         decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                   Colors.grey,
                  Color.fromARGB(255, 206, 14, 14),
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              )
            ),
         child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset("images/delivery.png"),

            SizedBox(height: 12,),

            ElevatedButton(
              child: const Text("Place Order"),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                padding: EdgeInsets.all(20)
              ),
              onPressed: () 
              {
                addOrderDetails();
              },
            ),

          ],
        ),
      ),
    );
  }
}