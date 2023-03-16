import 'dart:convert';

import 'package:flutter/material.dart';
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
        primarySwatch: Colors.blue,
      ),
      home: HomeApp(),
    );
  }
}

/* 
ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 200,
            child: Center(
              child: Text(
                index.toString(),
              ),
            ),
          ),
        ),
      ),
      */

class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  final String url = "https://api.github.com/users/AliJawadSubhan";
  String? name;
  bool? isLoading = false;
  callApi() async {
    setState(() {
      isLoading = true;
    });
    var uri = Uri.parse(url);
    try {
      http.Response response = await http.get(uri);

      Map<String, dynamic> jsonnn = jsonDecode(response.body);
      setState(() {
        name = jsonnn['login'] ?? jsonnn['message'];
      });
      print(response.body);
      print(response.statusCode);
      print(jsonnn['bio']);
    } catch (exception) {
      print(exception.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api'.toUpperCase()),
        centerTitle: true,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (name == null) const Text("Press the button"),
          if (name != null) Text(name!),
          if (isLoading!)
            const SizedBox(
              width: 200,
              child: LinearProgressIndicator(),
            ),
          ElevatedButton(
            onPressed: callApi,
            child: const Text(
              "Api call",
            ),
          ),
        ],
      ),
    );
  }
}
