import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lapo_user/assistantMethod/assistant_methods.dart';
import 'package:lapo_user/models/sellers.dart';
import 'package:lapo_user/widgets/sellers_design.dart';
import 'package:lapo_user/widgets/my_drawer.dart';
import 'package:lapo_user/widgets/progress_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> 
{
  final items = [
    "slider/0.jpg",
    "slider/1.jpg",
    "slider/2.jpg",
    "slider/3.jpg",
    "slider/4.jpg",
    "slider/5.jpg",
    "slider/6.jpg",
    "slider/7.jpg",
    "slider/8.jpg",
    "slider/9.jpg",
    "slider/10.jpg",
    "slider/11.jpg",
    "slider/12.jpg",
    "slider/13.jpg",
    "slider/14.jpg",
    "slider/15.jpg",
    "slider/16.jpg",
    "slider/17.jpg",
    "slider/18.jpg",
    "slider/19.jpg",
    "slider/20.jpg",
    "slider/21.jpg",
    "slider/22.jpg",
    "slider/23.jpg",
    "slider/24.jpg",
    "slider/25.jpg",
    "slider/26.jpg",
    "slider/27.jpg",
  ];

  @override
  void initState() {
    super.initState();

    clearCartNow(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                 Color.fromARGB(82, 255, 255, 255),
                  Color.fromARGB(255, 206, 14, 14),
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(0.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              )
            ),
          ),
        title: const Text(
          "LAPO",
          style: TextStyle(fontSize: 40, fontFamily: "Signatra", color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        ),
        drawer: const MyDrawer(),
        body: CustomScrollView(
          slivers:[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * .3,
                  width: MediaQuery.of(context).size.width,
                  child: CarouselSlider(
                     options: CarouselOptions(
                      height: 400,
                      aspectRatio: 16/9,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 2),
                      autoPlayAnimationDuration: const Duration(milliseconds: 500),
                      autoPlayCurve: Curves.decelerate,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      scrollDirection: Axis.horizontal,
                     ),
                     items: items.map((index) {
                        return Builder(builder: (BuildContext context){
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 1.0),
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              ),


                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Image.asset(
                                index,
                                fit: BoxFit.fill,
                                ),
                              ),
                          );
                        });
                     }).toList(),
                  ),
                ),
                ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                .collection("sellers")
                .snapshots(),
              builder: (context, snapshot)
              {
                return !snapshot.hasData 
                  ? SliverToBoxAdapter(child: Center(child: circularProgress(),),) 
                  : SliverStaggeredGrid.countBuilder(
                      crossAxisCount: 1,
                      staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
                      itemBuilder: (context, index) 
                      {
                        Sellers sModel = Sellers.fromJson(
                            snapshot.data!.docs[index].data()! as Map<String, dynamic>
                        );
                        //design for display sellers/cafe/restaurants
                        return SellersDesignWidget(
                          model: sModel,
                          context: context,
                          );
                      },
                      itemCount: snapshot.data!.docs.length,
                  );
              },
            ),
          ],
        ),
    );
  }
}