import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_project/page/form.dart';
import 'components/Navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:google_maps_flutter/google_maps_flutter.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
 
class _MyHomePageState extends State<Home> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Marker> marker = [];
  List<Marker> list = const [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(18.80014624536438, 98.91819678246976),
      ),
      Marker(
      markerId: MarkerId('2'),
      position: LatLng(18.80014624536438, 98.91819678246976),
      ),
      Marker(
      markerId: MarkerId('3'),
      position: LatLng(18.80137866086987, 98.92599832266569),
      ),
      Marker(
      markerId: MarkerId('4'),
      position: LatLng(18.804884473392917, 98.91652408987282),
      ),
      Marker(
      markerId: MarkerId('5'),
      position: LatLng(18.799968507642404, 98.9225473254919),
      ),
      Marker(
      markerId: MarkerId('6'),
      position: LatLng(18.804449662662435, 98.91985137015583),
      ),
  ];

  @override
  void initState(){
    super.initState();
    marker.addAll(list);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Cautious Spots"),
        leading: IconButton(
            iconSize: 30.0,
            onPressed: () {},
            icon: Icon(
              Icons.location_on,
              color: Colors.white,
            )),
      ),
      body:GoogleMap(
          initialCameraPosition:
              CameraPosition(target: LatLng(18.802177, 98.921108), zoom: 15),
              markers: Set<Marker>.of(marker)
             ),
      
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MyForm()));
        },
        icon: Icon(Icons.fiber_manual_record_outlined),
        label: Text("Add new pin"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
