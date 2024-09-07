import 'package:basic/detailspage.dart';
import 'package:flutter/material.dart';

import 'login.dart';
//import 'package:flutter/foundation.dart';


void main() => runApp(const MyHomeApp());

class MyHomeApp extends StatefulWidget {
  // const MyHomeApp({super.key});
  const MyHomeApp({Key? key}) : super(key: key);
  @override
  State<MyHomeApp> createState() => MyHomePage();


  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Drawer',

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomeApp(),


    );
  }




}


class MyHomePage extends State<MyHomeApp> {
  // const MyHomePage({super.key});

  bool _isDarkModeEnabled = false;


  void navigateNextPage(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return const LoginPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery
        .of(context)
        .size
        .width;
    double h = MediaQuery
        .of(context)
        .size
        .height;
    return MaterialApp(
        theme: _isDarkModeEnabled ? ThemeData.dark() : ThemeData.light(),

        home:Scaffold(
          appBar: AppBar(
            title: const Text('HOME'),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text(
                    'welcome to farmera!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  onTap: () {
                    // Handle drawer item click for home
                    Navigator.pop(MyHomePage as BuildContext);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.lightbulb_circle_outlined),
                  title: const Text('Dark Mode'),
                  onTap: () {
                    //Navigator.of(context).pushReplacement(
                    //MaterialPageRoute(builder: (_) => const MyNewApp()),
                    //);
                    //onTap: () {
                    setState(() {
                      _isDarkModeEnabled = !_isDarkModeEnabled;
                    });
                  },


                ),



                ListTile(
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text('Logout'),
                  onTap: () {
                    // Handle drawer item click for logout
                    // Navigator.pop(context);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                    );
                  },
                ),
              ],
            ),
          ),


          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.center,
              ),
              SizedBox(
                width: w * 0.6,
                height: h * 0.2,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const MyDetailApp()),
                    );
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    /* MaterialStateProperty.resolveWith((states){
                    if(states.contains(MaterialState.pressed)) {
                      return Colors.green;
                    }
                    return null;
                  })*/
                  ),
                  child: const Text(
                    "FIND WORK",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );



  }


}
