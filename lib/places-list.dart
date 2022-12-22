import 'package:flutter/material.dart';
import 'package:flutter_maps/map-view.dart';
import 'package:flutter_maps/place.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlacesList extends StatefulWidget {
  final String search;

  PlacesList({required this.search});
  @override
  _PlacesListState createState() => _PlacesListState(getSearch: search);
}

class _PlacesListState extends State<PlacesList> {
  List<Place> places = [];
  String getSearch = '';
  List<Widget> listOfPlaces = [];

  _PlacesListState({getSearch}) {
    this.getSearch = getSearch;
    searchNearByPlaces();
  }

  void showRoute(placeName) {
    print('Send $placeName');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => (MapView(
                  place: placeName,
                ))));
  }

  Future<void> searchNearByPlaces() async {
    var url =
        'URL';
    http.Response response = await http.get(Uri.parse(url));
    Map<String, dynamic> result = jsonDecode(response.body);
    Iterable resultObjects = result['results'];

    List<Map<String, dynamic>> points = [];

    resultObjects.forEach((element) {
      points.add(Map.from(element));

      //Whole object
      Map<String, dynamic> e = Map.from(element);

      // fetching geocoordinates
      Map<String, dynamic> geometry = e['geometry'];

      //Fetching longitude and latitude
      Map<String, dynamic> locationCoords = geometry['location'];

      //Festching name and address
      String placeName = e['name'];
      String placeAddress = e['vicinity'];

      places.add(Place(
          placeName: placeName,
          placeAddress: placeAddress,
          lat: locationCoords['lat'],
          long: locationCoords['lng']));
    });
    print('MY PLACES');
    int cnt = 0;

    setState(() {
      for (var i in places) {
        cnt += 1;
        var addPlace = GestureDetector(
          onTap: () {
            showRoute(i.placeName);
          },
          child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: Column(
                children: [
                  Text(
                    i.placeName,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                        decoration: TextDecoration.none,
                        fontFamily: 'Lato'),
                  ),
                  Text(i.placeAddress,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                          fontFamily: 'Lato'))
                ],
              )),
        );
        listOfPlaces.add(addPlace);
        print(cnt);
        if (cnt == 5) {
          break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: Container(
        child: Column(
          children: listOfPlaces,
        ),
      ),
    );
  }
}
