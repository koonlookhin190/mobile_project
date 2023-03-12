import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_project/page/components/Navbar.dart';
import 'package:mobile_project/page/home.dart';

class MyRequest extends StatefulWidget {
  const MyRequest({super.key});

  @override
  State<MyRequest> createState() => _MyRequestState();
}

class _MyRequestState extends State<MyRequest> {
  Query dbRef = FirebaseDatabase.instance.ref().child('Request');
  DatabaseReference reference =
      FirebaseDatabase.instance.ref().child('Request');
  DatabaseReference dbRef2 = FirebaseDatabase.instance.ref().child('Spot');
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Request');
  Widget listItem({required Map listOfSpot}) {
    return Container(
        margin: EdgeInsets.all(10),
        child: TextButton(
            style: TextButton.styleFrom(
              // side: BorderSide(width: 0.5),
              padding: const EdgeInsets.all(10),
              backgroundColor: Colors.white, // Background Color
            ),
            onPressed: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    children: [
                      ClipOval(
                          child: Image.network(
                        'https://png.pngitem.com/pimgs/s/146-1468281_profile-icon-png-transparent-profile-picture-icon-png.png',
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        listOfSpot['User'],
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ],
                  ),
                ),
                Column(children: [
                  const SizedBox(
                    width: 50,
                  ),
                  Container(
                    child: Column(children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Title : " + listOfSpot['Title'],
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Latitude : " + listOfSpot['Lat'],
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Longitude : " + listOfSpot['Lng'],
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Detail : " + listOfSpot['Detail'],
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ]),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Container(
                    padding: EdgeInsets.all(0),
                    margin: EdgeInsets.all(10),
                    height: 400,
                    width: 500,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Color.fromARGB(150, 0, 0, 0))),
                    child: GoogleMap(
                      zoomControlsEnabled: false,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(double.parse(listOfSpot['Lat']),
                              double.parse(listOfSpot['Lng'])),
                          zoom: 17),
                      markers: {
                        Marker(
                          markerId: const MarkerId("pin"),
                          position: LatLng(double.parse(listOfSpot['Lat']),
                              double.parse(listOfSpot['Lng'])),
                        ),
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          color: Colors.green,
                          iconSize: 40,
                          onPressed: () {
                            Map<String, String> newData = {
                              'User': listOfSpot['User'],
                              'Detail': listOfSpot['Detail'],
                              'Title': listOfSpot['Title'],
                              'Lat': listOfSpot['Lat'],
                              'Lng': listOfSpot['Lng']
                            };
                            dbRef2.push().set(newData);
                            ref.child(listOfSpot['key']).remove();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home()));
                          },
                          icon: const Icon(Icons.check_box)),
                      const SizedBox(
                        width: 230,
                      ),
                      IconButton(
                          color: Colors.red,
                          iconSize: 40,
                          onPressed: () {
                            ref.child(listOfSpot['key']).remove();
                          },
                          icon: const Icon(Icons.remove_circle)),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  )
                ])
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("List of request"),
          backgroundColor: Colors.red,
        ),
        body: Container(
          color: Color.fromARGB(120, 0, 0, 0),
          height: double.infinity,
          child: FirebaseAnimatedList(
            query: dbRef,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Map listOfSpot = snapshot.value as Map;
              listOfSpot['key'] = snapshot.key;
              return listItem(listOfSpot: listOfSpot);
            },
          ),
        ));
  }
}
