import 'package:rijksmuseum/models/collection_models/art_object.dart';
import 'package:rijksmuseum/models/detail_models/art_object_detail_response.dart';
import 'package:flutter/material.dart';
class MobileAppItems{
  static int pageNumber=1;
  static int numberOfItems=5;
  static String apiKey="";

  static bool homeScreenShown=false;

  //language can be "nl" or "en"
  static String collectionApiAdress(String language){return "https://www.rijksmuseum.nl/api/$language/collection?key=$apiKey&culture=$language&p=$pageNumber&ps=$numberOfItems";}
  static const backgroundColor=Color(0xfff2f2f2);

}
