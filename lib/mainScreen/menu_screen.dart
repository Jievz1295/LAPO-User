import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lapo_user/assistantMethod/assistant_methods.dart';
import 'package:lapo_user/models/menus.dart';
import 'package:lapo_user/models/sellers.dart';
import 'package:lapo_user/splashScreen/splash_screen.dart';
import 'package:lapo_user/widgets/menus_design.dart';
import 'package:lapo_user/widgets/progress_bar.dart';
import 'package:lapo_user/widgets/text_widget_header.dart';


class MenusScreen extends StatefulWidget 
{
  final Sellers? model;
  const MenusScreen({super.key, this.model});

  @override
  State<MenusScreen> createState() => _MenusScreenState();
}

class _MenusScreenState extends State<MenusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
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
                clearCartNow(context);
                Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
              },
            ),

        title: const Text(
          "LAPO",
          style: TextStyle(fontSize: 40, fontFamily: "Signatra", color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
          ),
        body: CustomScrollView(
          slivers: [
           SliverPersistentHeader(pinned: true, delegate: TextWidgetHeader(title: "${widget.model!.sellerName} Menus")),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
              .collection("sellers")
              .doc(widget.model!.sellerUID)
              .collection("menus",)
              .orderBy("publishedDate", descending: true)
              .snapshots(),
            builder: (context, snapshot) 
            {
                return !snapshot.hasData 
                    ? SliverToBoxAdapter(
                      child: Center(child: circularProgress(),),
                      )
                    : SliverStaggeredGrid.countBuilder(
                        crossAxisCount: 1,
                        staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
                        itemBuilder: (context, index) 
                        {
                          Menus model = Menus.fromJson(
                            snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                          );
                          return MenusDesignWidget(
                            model: model, 
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