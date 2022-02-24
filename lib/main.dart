// @dart=2.5
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:signin_demo/utils/loginpage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

String finUrl;
String finname;
String finemail;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToMyHomePage();
  }

  _navigateToMyHomePage() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (ct) => MyHomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(
          image: AssetImage('assets/flutter.webp'),
        )
              // image: NetworkImage('https://cdn.dribbble.com/users/1622791/screenshots/11174104/flutter_intro.png')),
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    if (isLoading == true) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Sign In'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Sign In'),
        ),
        body: Center(
          child: ElevatedButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                await signInwithGoogle();

                print(finUrl);
                print(finUrl);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (ctx) => HomePage(finemail, finname, finUrl)));
              },
              child: Text(
                'Sign In using Google',
                style: TextStyle(fontSize: 18),
              )),
        ),
      );
    }
  }
}

Future<UserCredential> signInwithGoogle() async {
  final GoogleSignInAccount googleuser = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication googleAuth = await googleuser.authentication;
  final GoogleAuthCredential credential = GoogleAuthProvider.credential(
    idToken: googleAuth.idToken,
    accessToken: googleAuth.accessToken,
  );
  finemail = googleuser.email;
  finname = googleuser.displayName;
  finUrl = googleuser.photoUrl;

  return await FirebaseAuth.instance.signInWithCredential(credential);
}
