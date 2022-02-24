import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:signin_demo/main.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<void> _signOut() async {
  await _auth.signOut();
  await GoogleSignIn().signOut();
}

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  String url;
  String name;
  String email;
  HomePage(this.email, this.name, this.url);

  @override
  Widget build(BuildContext context) {
    print(name);
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: GestureDetector(
                onTap: () {
                  _signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (ctx) => MyHomePage()));
                },
                child: Icon(Icons.logout)),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Container(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(url),
                  radius: 60,
                ),
              ),
            ),
            SizedBox(height: 5,),
            Text(name,style: TextStyle(fontSize: 23),),
            Text(email,style: TextStyle(fontSize: 19),)
          ],
        ),
      ),
    );
  }
}
