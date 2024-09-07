import 'package:basic/login.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'NavigationBar.dart';
class MyPostApp extends StatefulWidget {
  // const MyHomeApp({super.key});
  const MyPostApp({Key? key}) : super(key: key);

  @override
  State<MyPostApp> createState() => PostDetailsPage();


  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Drawer',

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyPostApp(),


    );
  }

}
class PostDetailsPage extends State<MyPostApp> {
  bool _isDarkModeEnabled = false;
  void navigateNextPage(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return const LoginPage();
    }));
  }

  final TextEditingController locationController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController payController = TextEditingController();
  final TextEditingController workController = TextEditingController();
  final TextEditingController daysController = TextEditingController();



  //PostDetailsPage(String id, {super.key});


  void _postDetails(BuildContext context) {
    String name = nameController.text;
    String phone = phoneController.text;
    String location=locationController.text;
    String Pay =payController.text;
    String work=workController.text;
    String days=daysController.text;


    // Save details to Firestore
    FirebaseFirestore.instance.collection('details').add({
      'Name': name,
       'Phone no.':phone,
      'Location':location,
      'Pay/Day':Pay,
      'work period':work,
      'No of workers required':days,

    }).then((_) {
      // Clear the input field after successfully posting the details
      nameController.clear();
      locationController.clear();
      phoneController.clear();
      locationController.clear();
      payController.clear();
      workController.clear();
      daysController.clear();

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Details posted successfully')),
      );
    }).catchError((error) {
      // Show an error message if something goes wrong
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to post details: $error')),
      );
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        theme: _isDarkModeEnabled ? ThemeData.dark() : ThemeData.light(),
    home: Scaffold(
      //appBar: AppBar(title: const Text('Post Details')),
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const PostButton()),
                );
                // Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: const Text('Post Details'),
      ),
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

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone no.'),
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(labelText: 'Location'),
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: payController,
              decoration: const InputDecoration(labelText: 'Pay/day'),
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: workController,
              decoration: const InputDecoration(labelText: 'Work period'),
            ),
            TextField(
              controller: daysController,
              decoration: const InputDecoration(labelText: 'No of workers required'),
            ),

            ElevatedButton(
              onPressed: () => _postDetails(context),
              child: const Text('Post'),
            ),
          ],
        ),
      ),
    ),
    );
  }

}
