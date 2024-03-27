import 'package:flutter/material.dart';
import 'package:lapo_user/mainScreen/item_detail_screen.dart';
import 'package:lapo_user/models/items.dart';

// ignore: must_be_immutable
class ItemsDesignWidget extends StatefulWidget 
{
  Items? model;
  BuildContext? context;

  ItemsDesignWidget({super.key, this.model, this.context});


  @override
  State<ItemsDesignWidget> createState() => _ItemsDesignWidgetState();
}



class _ItemsDesignWidgetState extends State<ItemsDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemDetailScreen(model: widget.model)));
      },
      splashColor: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          height: 350,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Divider(
                height: 40,
                thickness: 3,
                color: Colors.grey[300],
              ),
              Image.network(
                widget.model!.thumbnailUrl!,
                height: 230.0,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 1.0,),
              Text(
                widget.model!.title!,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: "Kiwi",
                ),
              ),
              Text(
                widget.model!.shortInfo!,
                style: const TextStyle(
                  color: Color.fromARGB(255, 56, 56, 56),
                  fontSize: 12,
                  //fontFamily: "Kiwi",
                ),
              ),
              Divider(
                height: 10,
                thickness: 3,
                color: Colors.grey[300],
              ),
            ],
          ),
        ),
        ),
    );
  }
}