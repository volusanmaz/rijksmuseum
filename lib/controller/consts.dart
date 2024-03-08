class Consts{
  static String ApiKey="";

  //language can be "nl" or "en"
  static String CollectionApiAdress(String language){return "https://www.rijksmuseum.nl/api/$language/collection?key=$ApiKey&culture=$language";}


}
