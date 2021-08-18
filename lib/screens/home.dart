import 'dart:convert';
import 'package:chill_n_grill/model/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' show get;

import 'event_details.dart';

class HomePage extends StatelessWidget {
  final List<EventImages> eventimages;

  HomePage(this.eventimages);

  Widget build(context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      itemCount: eventimages.length,

      staggeredTileBuilder: (index) => StaggeredTile.fit(1),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      itemBuilder: (context, int currentIndex) {
        return createViewItem(eventimages[currentIndex], context);
      },
    );
  }

  Widget createViewItem(EventImages spacecraft, BuildContext context) {
    return InkWell( onTap: (){
      var route = new MaterialPageRoute(
        builder: (BuildContext context) =>
        new SecondScreen(value: spacecraft),
      );
      Navigator.of(context).push(route);
    },
      child: new  ClipRRect(

        borderRadius: BorderRadius.circular(16.0),
        child: Image.network(spacecraft.imageUrl,
            fit: BoxFit.cover),

      ),

    );

  }
}
Future<List<EventImages>> downloadJSON() async {
  final jsonEndpoint =
      "https://jsonplaceholder.typicode.com/photos/";

  final response = await get(Uri.parse(jsonEndpoint));

  if (response.statusCode == 200) {
    List spacecrafts = json.decode(response.body);
    return spacecrafts
        .map((spacecraft) => new EventImages.fromJson(spacecraft))
        .toList();
  } else
    throw Exception('We were not able to successfully download the json data.');
}