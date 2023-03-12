import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:testproject2/page/home.dart';
import 'package:testproject2/page/listOfSpot.dart';

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final titleController = TextEditingController();
  final detailController = TextEditingController();
  var latitude = "None";
  var longitude = "None";
  late DatabaseReference dbRef;
  final user = FirebaseAuth.instance.currentUser!;

  List<Marker> listMark = [];
  CollectionReference location = FirebaseFirestore.instance.collection('location');
  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Request');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create new pin"),
        backgroundColor: Colors.red,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              height: 400,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(18.802177, 98.921108), zoom: 15),
                onTap: (LatLng tap) {
                  latitude = tap.latitude.toString();
                  longitude = tap.longitude.toString();
                  setState(() {
                    listMark = [];
                    listMark.add(Marker(
                      markerId: MarkerId(tap.toString()),
                      position: tap,
                    ));
                  });
                },
                markers: Set.from(listMark),
              ),
            ),
            Text("Latitude : "+latitude),
            const SizedBox(
              height: 10,
            ),
             Text("Longitude : "+longitude),
              const SizedBox(
              height: 10,
            ),
            Container(
              width: 350,
              child: TextField(
                controller: titleController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  hintText: 'Title',
                  hintStyle:
                      const TextStyle(color: Color.fromARGB(255, 71, 69, 69)),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: 350,
              child: TextField(
                controller: detailController,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  hintText: 'Detail',
                  hintStyle:
                      const TextStyle(color: Color.fromARGB(255, 71, 69, 69)),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton.extended(
                    label: Text('Post'), // <-- Text
                    backgroundColor: Colors.black,
                    icon: Icon(
                      // <-- Icon
                      Icons.local_post_office_outlined,
                      size: 24.0,
                    ),
                    onPressed: () {
                      double.parse(latitude);
                      Map<String,String>pin ={
                        'User': user.email!,
                        'Detail':detailController.text,
                        'Title':titleController.text,
                        'Lat':latitude,
                        'Lng':longitude
                      };
                      dbRef.push().set(pin);
                      location.add({'Lat':latitude,'Lng':longitude});
                      Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                    }),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
