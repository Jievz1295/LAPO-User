import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lapo_user/models/sellers.dart';
import 'package:lapo_user/widgets/sellers_design.dart';

class SearchScreen extends StatefulWidget 
{
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}




class _SearchScreenState extends State<SearchScreen> 
{
  Future<QuerySnapshot>? restaurantsDocumentsList;
  String sellerNameText = "";

  initSearchingRestaurant(String textEntered)
  {
    restaurantsDocumentsList = FirebaseFirestore.instance
    .collection("sellers")
    .where("sellerName", isGreaterThanOrEqualTo: textEntered)
    .get();
  }


  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                 Colors.white,
                 Color.fromARGB(255, 206, 14, 14),
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(0.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              )
            ),
          ),
          title: TextField(
            onChanged: (textEntered)
            {
              setState(() {
                sellerNameText = textEntered;
              });
              //init search
              initSearchingRestaurant(textEntered);
            },
            decoration: InputDecoration(
              hintText: "Search Restaurants/Stalls/Cafes here...",
              hintStyle: TextStyle(color: Colors.white54),
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                color: Colors.white,
                onPressed: () 
                {
                  initSearchingRestaurant(sellerNameText);
                },
              ),
            ),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: restaurantsDocumentsList,
        builder: (context, snapshot) 
        {
          return snapshot.hasData 
          ? ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) 
            {
              Sellers model = Sellers.fromJson(
                snapshot.data!.docs[index].data()! as Map<String, dynamic>
              );

              return SellersDesignWidget(
                model: model,
                context: context,
              );
            },
          ) 
          : Center(child: Text("No Record Found"),);
        },
      ),
    );
  }
}