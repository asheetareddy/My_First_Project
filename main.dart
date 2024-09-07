import 'package:basic/login.dart';
import 'package:basic/register.dart';
//import 'package:basic/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


import 'homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key ?key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title:'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const Splash(),
    );
  }

}

class Material{
}
class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState(){

    super.initState();
    Future.delayed(const Duration(seconds: 5),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Register()));
    });

  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets1/Logo.jpeg',height:300 ),
            const SizedBox(height:30 ,),
            const CircularProgressIndicator(
              color: Colors.white,
            )
          ],
        ),

      ),
    );

  }
}

//class MyApp extends StatelessWidget {
 // const MyApp({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     debugShowCheckedModeBanner: false,
     home: StreamBuilder<User?>(
       stream: FirebaseAuth.instance.authStateChanges(),
         builder: (context, snapshot) {
           if (snapshot.hasData) {
             return const HomePage();
           } else {
             return const LoginPage();
           }
         },
    ),
   );
  }





/*
import 'package:flutter/material.dart';
import 'package:project/login.dart';

//import 'NavigationBar.dart';
//import 'package:splashscreen/sidebar.dart';
//import 'package:firebase_core/firebase_core.dart';


void main() {async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key ?key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title:'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const Splash(),
    );
  }

}

class Material {
}
class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState(){

    super.initState();
    Future.delayed(const Duration(seconds: 5),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginPage()));
    });

  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.jpeg',height: 250),
            const SizedBox(height:30 ,),
            const CircularProgressIndicator(
              color: Colors.white,
            )
          ],
        ),

      ),
    );

  }
}


/*class MyBar extends StatefulWidget {
  const MyBar({super.key});


  @override
  _MyBarState createState() => _MyBarState();
}

class _MyBarState extends State<MyBar> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: const Log(),
        appBar: AppBar(
            title: const Text('Navigation Drawer App'),
            backgroundColor: Colors.green),
        body: const Center(
            child: Text(
              'Main Page',
              style: TextStyle(fontSize: 40.0),
            )),
      ),
    );
  }
}*/

 */