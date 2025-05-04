import 'dart:convert';

import 'package:first_https/home_screen.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Screen')),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (email) {
                  return email != null && email.isEmpty
                      ? 'Please enter your email'
                      : null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                ),
                keyboardType: TextInputType.visiblePassword,
                validator: (password) {
                  if (password == null || password.isEmpty) {
                    return 'Please enter your password';
                  } else if (password.length < 6) {
                    return 'Password must be at least 6 characters';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 20),
              isLoading
                  ? CircularProgressIndicator()
                  : SizedBox(
                    width: 300,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          // call the login API
                          String token = await loginAPI(
                            _emailController.text,
                            _passwordController.text,
                          );
                          if (token == "error") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Login failed")),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Login successful")),
                            );
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) {
                                  return HomeScreen(token: token);
                                },
                              ),
                            );
                          }
                        }
                      },
                      child: const Text('Login'),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  bool isLoading = false;

  Future<String> loginAPI(String email, String password) async {
    Uri url = Uri.parse("https://api.escuelajs.co/api/v1/auth/login");
    //// Start Loading
    setState(() {
      isLoading = true;
    });
    http.Response response = await http.post(
      url,
      body: jsonEncode({"email": email, "password": password}),
      headers: {"Content-Type": "application/json"},
    );

    // Stop Loading
    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 201) {
      Map mapBody = jsonDecode(response.body);
      return mapBody['access_token'];
    } else {
      return "error";
    }
  }
}
