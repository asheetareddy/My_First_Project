
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'NavigationBar.dart';
import 'login.dart';
//import 'package:flutter/foundation.dart';


class MyDetailApp extends StatefulWidget {
  // const MyHomeApp({super.key});
  const MyDetailApp({Key? key}) : super(key: key);

  @override
  State<MyDetailApp> createState() => DetailsListPage();


  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Drawer',

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyDetailApp(),


    );
  }

}


class DetailsListPage extends State<MyDetailApp> {
  // const MyHomePage({super.key});

  bool _isDarkModeEnabled = false;


  void navigateNextPage(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return const LoginPage();
    }));
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: _isDarkModeEnabled ? ThemeData.dark() : ThemeData.light(),

      home: Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const MyHomeApp()),
                  );
                 // Scaffold.of(context).openDrawer();
                },
              );
            },
          ),

          title: const Text('Posts'),
        ),


          /*return IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () {
//Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const MyHomeApp()),
              );
            },
          ),
          title: const Text('Posts'),
*/


             endDrawer: Drawer(

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





        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('details').snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('No data available'),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data!.docs[index].data() as Map<
                    String,
                    dynamic>;

                return ListTile(
                  title: Text(data['Name']),
                  subtitle: Text(data['Location']),
                  onTap: () {
                    // Navigate to a details screen for the selected item
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailScreen(docId: snapshot.data!.docs[index].id),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }


}
class DetailScreen extends StatelessWidget {
  final String docId;

  const DetailScreen({super.key, required this.docId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Screen'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('details').doc(docId).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(
              child: Text('No data available'),
            );
          }

          var data = snapshot.data!.data() as Map<String, dynamic>;

          return Padding(
            padding: EdgeInsets.all(50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name: ${data['Name']}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                Text('Phone: ${data['Phone no.']}'),
                SizedBox(height: 10.0),
                Text('Location: ${data['Location']}'),
                const SizedBox(height: 10.0),
                Text('Pay/Day: ${data['Pay/Day']}'),
                const SizedBox(height: 10.0),
                Text('Work Period: ${data['work period']}'),
                const SizedBox(height: 10.0),
                Text('No of workers Required: ${data['No of workers required']}'),
              ],
            ),
          );
        },
      ),
    );
  }
}








