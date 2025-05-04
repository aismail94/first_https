import 'package:first_https/models/profile.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  final String token;

  const HomeScreen({super.key, required this.token});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Profile? profile;

  @override
  void initState() {
    super.initState();
    getProfile(widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              profile != null
                  ? SizedBox(
                    width: 240,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            CircleAvatar(child: Image.network(profile!.avatar)),
                            const SizedBox(height: 12),
                            Text(profile!.email),
                            const SizedBox(height: 12),
                            Text(profile!.name),
                            const SizedBox(height: 12),
                            Text(profile!.role),
                          ],
                        ),
                      ),
                    ),
                  )
                  : CircularProgressIndicator(),

              ElevatedButton(onPressed: () {}, child: Text("Products")),
            ],
          ),
        ),
      ),
    );
  }

  Future<Profile?> getProfile(String token) async {
    Uri url = Uri.parse("https://api.escuelajs.co/api/v1/auth/profile");
    http.Response response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    if (response.statusCode == 200) {
      Map mapBody = jsonDecode(response.body);
      Profile profileData = Profile.fromJson(mapBody);
      setState(() {
        profile = profileData;
      });
      return profileData;
    } else {
      return null;
    }
  }
}
