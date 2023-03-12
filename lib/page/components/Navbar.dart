import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_project/page/listOfRequest.dart';
import 'package:mobile_project/page/listOfSpot.dart';
import 'package:mobile_project/page/login.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            accountName: Text("Hello! Welcome to Cautious Spots"),
            accountEmail: Text(user.email!),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                  child: Image.network(
                'https://png.pngitem.com/pimgs/s/146-1468281_profile-icon-png-transparent-profile-picture-icon-png.png',
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              )),
            ),
          ),
          ListTile(
            leading: Icon(Icons.dangerous),
            title: Text('Cautious Spots'),
            onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MyList())),
          ),
          if(user.email =="hin@hotmail.com") ListTile(
            leading: Icon(Icons.doorbell),
            title: Text('Request'),
            onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MyRequest())),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              FirebaseAuth.instance.signOut();
            } 
          )
        ],
      ),
    );
  }
}
