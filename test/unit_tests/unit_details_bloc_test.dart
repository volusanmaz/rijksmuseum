import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:rijksmuseum/controller/detail_bloc.dart';
import 'package:rijksmuseum/models/detail_models/art_object_detail_response.dart';

class MockHttpClient extends Mock implements http.Client {}
class MockConnectivity extends Mock implements Connectivity {}

void main() {
  group('DetailBloc', () {
    late MockHttpClient mockHttpClient;
    late MockConnectivity mockConnectivity;
    late DetailBloc detailBloc;

    setUp(() {
      mockHttpClient = MockHttpClient();
      mockConnectivity = MockConnectivity();
      detailBloc = DetailBloc()
        ..httpClient = mockHttpClient
        ..connectivity = mockConnectivity;
    });

    test('fetchData returns ArtObjectResponse when http call completes successfully', () async {
      final selfLink = 'http://www.rijksmuseum.nl/api/en/collection/AK-MAK-187?key=0fiuZFh4';
      final mockResponse = {
        "elapsedMilliseconds": 483,
        "artObject": {
          "links": {
            "search": "http://www.rijksmuseum.nl/api/nl/collection"
          },
          "id": "en-AK-MAK-187",
          "priref": "677",
          "objectNumber": "AK-MAK-187",
          "language": "en",
          "title": "Shiva Nataraja",
          "copyrightHolder": null,
          "webImage": {
            "guid": "ed3bb15a-a6b9-4ecd-836c-942a6ad8a9cd",
            "offsetPercentageX": 50,
            "offsetPercentageY": 21,
            "width": 1780,
            "height": 2500,
            "url": "https://lh5.ggpht.com/vV5DJTpPEL5dOCFmytemK61JuTSX_9SQKI11U7uAhm4WB48zX6oyv8rXbBwYrSb7tPXUhERrROL8k2P9C5Q0NiOpCbs=s0"
          },
          "colors": [
            {
              "percentage": 51,
              "hex": "#949489"
            },
            {
              "percentage": 18,
              "hex": " #31322C"
            },
            {
              "percentage": 12,
              "hex": " #6E6E63"
            },
            {
              "percentage": 8,
              "hex": " #B4B4AF"
            },
            {
              "percentage": 5,
              "hex": " #53534A"
            },
            {
              "percentage": 3,
              "hex": " #0F100D"
            },
            {
              "percentage": 0,
              "hex": " #D6D7D3"
            }
          ],
          "colorsWithNormalization": [
            {
              "originalHex": "#949489",
              "normalizedHex": "#737C84"
            },
            {
              "originalHex": " #31322C",
              "normalizedHex": "#2F4F4F"
            },
            {
              "originalHex": " #6E6E63",
              "normalizedHex": "#737C84"
            },
            {
              "originalHex": " #B4B4AF",
              "normalizedHex": "#B5BFCC"
            },
            {
              "originalHex": " #53534A",
              "normalizedHex": "#2F4F4F"
            },
            {
              "originalHex": " #0F100D",
              "normalizedHex": "#000000"
            },
            {
              "originalHex": " #D6D7D3",
              "normalizedHex": "#FBF6E1"
            }
          ],
          "normalizedColors": [
            {
              "percentage": 51,
              "hex": "#808080"
            },
            {
              "percentage": 36,
              "hex": " #696969"
            },
            {
              "percentage": 8,
              "hex": " #A9A9A9"
            },
            {
              "percentage": 3,
              "hex": " #000000"
            },
            {
              "percentage": 0,
              "hex": " #D3D3D3"
            }
          ],
          "normalized32Colors": [],
          "materialsThesaurus": [],
          "techniquesThesaurus": [],
          "productionPlacesThesaurus": [],
          "titles": [
            "Shiva Nataraja"
          ],
          "description": "De vierarmige Shiva met wijd uitwaaierende haardos staat op één been in een geheel gebalanceerde danshouding. Omgeven door een ronde vlammenkrans.",
          "labelText": null,
          "objectTypes": [
            "sculpture",
            "figure"
          ],
          "objectCollection": [
            "sculptures"
          ],
          "makers": [],
          "principalMakers": [
            {
              "name": "anonymous",
              "unFixedName": "anonymous",
              "placeOfBirth": null,
              "dateOfBirth": null,
              "dateOfBirthPrecision": null,
              "dateOfDeath": null,
              "dateOfDeathPrecision": null,
              "placeOfDeath": null,
              "occupation": [],
              "roles": [],
              "nationality": null,
              "biography": null,
              "productionPlaces": [],
              "qualification": null,
              "labelDesc": "anonymous"
            }
          ],
          "plaqueDescriptionDutch": "Shiva in zijn gedaante als Nataraja (Koning der Dans), omringd door een vlammenkrans en afgebeeld in de anandatandava-houding, is tegelijkertijd de schepper en de vernietiger van de wereld. Onder zijn voet ligt een dwergje: het symbool van de onwetendheid. Rijk versierde bronzen beelden van hindoe goden werden op feestdagen meegedragen in processies. Door ringen aan de sokkel werden dan draagstokken gestoken.",
          "plaqueDescriptionEnglish": "Shiva is depicted here as Nataraja (Lord of the Dance), standing in a ring of fire in the anandatandava position. He is both the creator and destroyer of the world. He is standing on a dwarf, symbolising ignorance. Richly decorated bronze statues of Hindu gods like this are carried in processions during festivals. Rings at the side of the base are for the supporting sticks. ",
          "principalMaker": "anonymous",
          "artistRole": null,
          "associations": [],
          "acquisition": {
            "method": "loan",
            "date": "1972-01-01T00:00:00",
            "creditLine": "On loan from the Royal Asian Art Society in The Netherlands (purchase with the support of the Vereniging Rembrandt, 1935)"
          },
          "exhibitions": [],
          "materials": [
            "bronze (metal)"
          ],
          "techniques": [
            "casting"
          ],
          "productionPlaces": [],
          "dating": {
            "presentingDate": "c. 1100 - c. 1200",
            "sortingDate": 1100,
            "period": 11,
            "yearEarly": 1100,
            "yearLate": 1200
          },
          "classification": {
            "iconClassIdentifier": [
              "12H13(SHIVA)51"
            ],
            "iconClassDescription": [
              "Shiva dancing"
            ],
            "motifs": [],
            "events": [],
            "periods": [],
            "places": [],
            "people": [
              "Shiva"
            ],
            "objectNumbers": [
              "AK-MAK-187"
            ]
          },
          "hasImage": true,
          "historicalPersons": [
            "Shiva"
          ],
          "inscriptions": [],
          "documentation": [
            "Annette Löseke en Anna Grasskamp, 'Framing 'Asia' : results from a visitor study at the Rijksmuseum's Asian Pavilion', Aziatische Kunst 44 (2014) nr. 2, p. 50, fig. 2.",
            "Jan van Campen, 'Jaarverslag van de conservatoren over 2012', Aziatische Kunst 43 (2013),  nr. 2, p. 35.",
            "Inzoomer object op zaal, 2013 (Nederlands/English).",
            "P.C.M. Lunsingh Scheurleer, 'De menselijke gestalte in de Aziatische beeldhouwkunst op de tentoonstelling Rijksmuseum aan Zee: Hemelse beelden uit Oost en West', Sculptuur Studies 2008 (2009), p. 12-17.",
            "P.C.M. Lunsingh Scheurleer, 'The Human form in Asian sculpture in the exhibition Rijksmuseum aan Zee: Heavenly sculptures from east and west', Sculptuur Studies 2008 (2009), p. 104-109.",
            "Anna Slaczka, 'Devi aan Zee', Aziatische Kunst 38 (2008), nr. 4, p. 149, afb. 6.",
            "Renée Steenbergen, 'De Vereniging van Vrienden der Aziatische Kunst in het interbellum : Deftige verzamelaars, rijke donateurs en Indische fortuinen', Aziatische Kunst 38 (2008), nr. 3, p. 10, afb. 8.",
            "Robert Uterwijk, 'Als je zou kunnen zien, de boog van zijn wenkbrauw', Aziatische Kunst 37/1 (2007), pp.  23-27.",
            "Pauline Lunsingh Scheurleer, 'De Dansende Shiva', Aziatische Kunst 26/1 (1996), pp. 13-20.",
            "Karel van Kooij, 'Bold and Beautiful', Aziatische Kunst 19/4 (1999), pp. 2-23.",
            "Jean Varenne, L'art de l'Inde, Paris 1982, pl. 42.",
            "M. Derck, Indian art, London 1967, pl. 26.",
            "C. Sivaramamurti, South Indian Bronzes, Bombay 1963, pl. 696.",
            "H. Goetz, Indien, in: Kunst der Welt, Baden-Baden 1962, p. 185.",
            "Maandblad voor beeldende kunsten (1935), oct., p. 290-306."
          ],
          "catRefRPK": [],
          "principalOrFirstMaker": "anonymous",
          "dimensions": [
            {
              "unit": "cm",
              "type": "height",
              "precision": null,
              "part": null,
              "value": "153.0"
            },
            {
              "unit": "cm",
              "type": "width",
              "precision": null,
              "part": null,
              "value": "114.5"
            },
            {
              "unit": "cm",
              "type": "width",
              "precision": null,
              "part": null,
              "value": "73.5"
            },
            {
              "unit": "cm",
              "type": "depth",
              "precision": null,
              "part": null,
              "value": "44"
            },
            {
              "unit": "cm",
              "type": "height",
              "precision": null,
              "part": null,
              "value": "19"
            },
            {
              "unit": "kg",
              "type": "weight",
              "precision": "c.",
              "part": null,
              "value": "255"
            },
            {
              "unit": "kg",
              "type": "weight",
              "precision": "c.",
              "part": null,
              "value": "40"
            }
          ],
          "physicalProperties": [],
          "physicalMedium": "bronze",
          "longTitle": "Shiva Nataraja, anonymous, c. 1100 - c. 1200",
          "subTitle": "h 153.0cm × w 114.5cm",
          "scLabelLine": "India, Tamil Nadu, Chola style, 12th century, bronze",
          "label": {
            "title": "Shiva Nataraja",
            "makerLine": "India, Tamil Nadu, Chola style, 12th century, bronze",
            "description": "Shiva, in his manifestation as Nataraja (King of Dancers), represented in the anandatandava pose and encircled by a halo of fire, is both the creator and destroyer of the world. Beneath his foot is a dwarf, symbolizing ignorance. Richly decorated bronze figures of Hindu gods were carried in procession on feast days. Carrying poles were inserted through the rings on the base.",
            "notes": null,
            "date": "2018-03-23"
          },
          "showImage": true,
          "location": "AK-1"
        },
        "artObjectPage": {
          "id": "en-AK-MAK-187",
          "similarPages": [],
          "lang": "en",
          "objectNumber": "AK-MAK-187",
          "tags": [],
          "plaqueDescription": "Shiva is depicted here as Nataraja (Lord of the Dance), standing in a ring of fire in the anandatandava position. He is both the creator and destroyer of the world. He is standing on a dwarf, symbolising ignorance. Richly decorated bronze statues of Hindu gods like this are carried in processions during festivals. Rings at the side of the base are for the supporting sticks. ",
          "audioFile1": null,
          "audioFileLabel1": null,
          "audioFileLabel2": null,
          "createdOn": "0001-01-01T00:00:00",
          "updatedOn": "2012-09-18T14:06:03.0178053+00:00",
          "adlibOverrides": {
            "titel": null,
            "maker": null,
            "etiketText": null
          }
        }

      };

      // Mocking connectivity check to return internet connection
      when(() => mockConnectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.wifi);

      // Mocking HTTP call to return a successful response
      when(() => mockHttpClient.get(Uri.parse(selfLink)))
          .thenAnswer((_) async => http.Response(json.encode(mockResponse), 200));

      expect(detailBloc.fetchData(selfLink), completes);

      // Verifying that the stream emits the expected ArtObjectResponse
      await expectLater(
        detailBloc.detailDataStream,
        emits(isA<ArtObjectResponse>()),
      );
    });
    test('fetchData emits an error when there is no internet connection', () async {

      final selfLink = 'http://www.rijksmuseum.nl/api/en/collection/AK-MAK-187?key=0fiuZFh4';
      when(() => mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => ConnectivityResult.none);



      await expectLater(
        detailBloc.fetchData(selfLink),
        throwsA(isA<Exception>().having((e) => e.toString(), 'description', contains("No internet"))),
      );

    });

  });
}
