import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class RandomNumberScreen extends StatefulWidget {
  const RandomNumberScreen({Key? key}) : super(key: key);

  @override
  _RandomNumberScreenState createState() => _RandomNumberScreenState();
}


//fetch all data from API
Future<http.Response> getRandomNumber() {
  return http
      .get(Uri.parse('https://csrng.net/csrng/csrng.php?min=1&max=1000'));
}


//convert response into object
//create class for random number
class RandomNumber {
  final String random;

  RandomNumber({required this.random});

  factory RandomNumber.fromJson(Map<String, dynamic> json) {
    return RandomNumber(
        random: json['random']
    );
  }
}


//Convert the http.Response to an RandomNumber
Future<RandomNumber> fetchRandomNumber() async {
  final response = await http
      .get(Uri.parse('https://csrng.net/csrng/csrng.php?min=1&max=1000'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return RandomNumber.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load random number');
  }
}


class _RandomNumberScreenState extends State<RandomNumberScreen> {

  //fetch data
  late Future<RandomNumber> futureRandomNumber;

  @override
  void initState() {
    super.initState();
    futureRandomNumber = fetchRandomNumber();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random number'),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          ElevatedButton(
          onPressed: () {
            setState(() {
            });
          },
          child: const Text('  Get New Random Number   '),
    ),
            FutureBuilder<RandomNumber>(
              future: futureRandomNumber,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data!.random);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          Text('Previous numbers'),
    ],
    ),
    );
    }
  }
