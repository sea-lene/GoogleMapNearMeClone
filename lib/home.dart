
import 'package:flutter/material.dart';
import 'package:flutter_maps/places-list.dart';

import 'package:flutter_maps/place.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String search = "";
  String setSearch = "";
  
  void navigateToList() {
    setState(() {
      setSearch = search;
      print(setSearch);
    });
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => (PlacesList(search: setSearch,))));
  }


  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        // both textfield is here as children
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              decoration: InputDecoration(labelText: 'Source'),
              onChanged: (value) => search = value,
            ),
          ),
          // this will set the value of source and destination
          ElevatedButton(
            onPressed: navigateToList,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            child: Text('Search'),
          ),
        ],
      ),
    );
  }
}
