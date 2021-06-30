import 'package:elememt3zignuts/screens/sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text("Home"),
        // ignore: avoid_print
        leading:  IconButton(icon: const Icon(Icons.menu),onPressed: () =>print("Drower code here") ,),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.9,
              width: double.infinity,
              color: Colors.grey[300],
              child:  Center(child: TextButton(onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool("isLoggedIn", false);
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const SignIn()));

              }, child: const Text("Logout",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 22,color: Colors.blueGrey),))),
            )

          ],
        ),
      ),
    );
  }
}
