
import 'package:first_https/login_screen.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.deepPurple.shade900,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red.shade900,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          labelStyle: TextStyle(
            color: Colors.deepPurple.shade900,
          ),
        ),
      ),
      home: LoginScreen(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() async {
//
//     Uri url = Uri.parse("https://dummyjson.com/users");
//
//     http.Response response = await http.get(url);
//     if(response.statusCode == 200) {
//       print("Success");
//       Map mapBody = jsonDecode(response.body);
//       List userList = mapBody['users'];
//       Map user3 = userList[2];
//       Map bank = user3['bank'];
//       String inbOne = bank["iban"];
//
//       String inbTwo = user3['users'][2]['bank']["iban"];
//
//
//       Map? address = mapBody['users'][3]['address'];
//       print(address!['country']);
//
//
//     } else if(response.statusCode == 404) {
//       print("Not Found");
//     } else if ( response.statusCode == 500) {
//       print("Server Error");
//     } else {
//       print("Error");
//     }
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text('You have pushed the button this many times:'),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
