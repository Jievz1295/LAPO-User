import 'package:flutter/material.dart';
import 'package:lapo_user/assistantMethod/cart_item_counter.dart';
import 'package:lapo_user/mainScreen/cart_screen.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget
{
  final PreferredSizeWidget? bottom;
  final String? sellerUID;
  const MyAppBar({super.key, this.bottom, this.sellerUID});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
  
  @override
  Size get preferredSize => bottom==null?Size(56, AppBar().preferredSize.height):Size(56, 80+AppBar().preferredSize.height);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        flexibleSpace: Container(
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
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: ()
            {
              Navigator.pop(context);
            },
          ),
        title: const Text(
          "LAPO",
          style: TextStyle(fontSize: 40, fontFamily: "Signatra", color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
         Stack(
          children: [
             IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.white,),
                onPressed: ()
                {
                  //send user to cart screen
                  Navigator.push(context, MaterialPageRoute(builder: (c)=> CartScreen(sellerUID: widget.sellerUID)));
                },
              ),
          Positioned(
                child: Stack(
                  children: [
                    const Icon(
                      Icons.brightness_1,
                      size: 20.0,
                      color: Colors.lightGreen
                    ),
                    Positioned(
                      top: 1,
                      right: 6,
                      child: Center(
                        child: Consumer<CartItemCounter>(
                          builder: (context, counter, c)
                          {
                            return Text
                            (
                              counter.count.toString(),
                              style:const TextStyle(color: Colors.white, fontSize: 12),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
         ),
      ],
    );
  }
}