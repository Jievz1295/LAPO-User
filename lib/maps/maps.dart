import 'package:url_launcher/url_launcher.dart';

class MapUtils
{
  MapUtils._();

  //latitude & longitude
  static Future<void> openMapWithPosition(double latitude, double longitude) async
  {
    String googleMapUrl = "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";

    if(await launch(googleMapUrl))
    {
      await launch(googleMapUrl);
    }
    else
    {
      throw "Couldn't open the map!";
    }
  }

  //text address
  static Future<void> openMapWithAddress(String fullAddress) async
  {
    String query = Uri.encodeComponent(fullAddress);
    String googleMapUrl = "https://www.google.com/maps/search/?api=1&query=$query";

     if(await launch(googleMapUrl))
    {
      await launch(googleMapUrl);
    }
    else
    {
      throw "Couldn't open the map!";
    }
  }
  
}