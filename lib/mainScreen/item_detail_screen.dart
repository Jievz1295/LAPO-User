import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lapo_user/assistantMethod/assistant_methods.dart';
import 'package:lapo_user/models/items.dart';
import 'package:lapo_user/widgets/app_bar.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

class ItemDetailScreen extends StatefulWidget 
{
 final Items? model;
 const ItemDetailScreen({super.key, this.model});

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> 
{
  
  TextEditingController counterTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) 
  {
 return Scaffold(
  appBar: MyAppBar(sellerUID: widget.model!.sellerUID),
  body: SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(widget.model!.thumbnailUrl.toString()),
        Padding(
          padding: const EdgeInsets.all(19.0),
          child: NumberInputPrefabbed.roundedButtons(
            controller: counterTextEditingController,
            incDecBgColor: Colors.amber,
            min: 1,
            max: 10,
            initialValue: 1,
            buttonArrangement: ButtonArrangement.incRightDecLeft,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.model!.title.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),
          ),
        ),

         Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.model!.shortInfo.toString(),
            style: const TextStyle(color: Colors.black54, fontSize: 19,),
          ),
        ),

         Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.model!.longDescription.toString(),
            textAlign: TextAlign.justify,
            style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "RM ${widget.model!.price}",
            style: const TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        
        const SizedBox(height: 10,),
        
        Center(
          child: InkWell(
            onTap: ()
            {
              int itemCounter = int.parse(counterTextEditingController.text);
              //1.check if item existed in cart
              List<String> separateItemIDsList = separateItemIDs();
              separateItemIDsList.contains(widget.model!.itemID)
                  ? Fluttertoast.showToast(msg: "Item is already in the Cart!") 
                  :
                  //2.add to cart
                  addItemToCart(widget.model!.itemID, context, itemCounter);

            },
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                  Color.fromARGB(255, 206, 14, 14),
                  Colors.yellow,
            
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                )
              ),
              //width: MediaQuery.of(context).size.width - 40,
              height: 50,
              child: const Center(
                child: Text(
                  "Add To Cart",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25, fontFamily: "Acme"),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  ),
);

  }
}