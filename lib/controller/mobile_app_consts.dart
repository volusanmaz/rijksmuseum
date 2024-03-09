import 'package:rijksmuseum/models/collection_models/art_object.dart';
import 'package:rijksmuseum/models/detail_models/art_object_detail_response.dart';

class MobileAppItems{
  static String ApiKey="";
  static List<ArtObject> CollectionData=[];
  static bool HomeScreenShown=false;
  static late ArtObjectResponse? DetailData;
  //language can be "nl" or "en"
  static String CollectionApiAdress(String language){return "https://www.rijksmuseum.nl/api/$language/collection?key=$ApiKey&culture=$language";}


}
