import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChuckNorrisJoke {
  final String joke;

  ChuckNorrisJoke({required this.joke});
}

class ChuckNorrisJokePage extends StatefulWidget {
  @override
  _ChuckNorrisJokePageState createState() => _ChuckNorrisJokePageState();
}

class _ChuckNorrisJokePageState extends State<ChuckNorrisJokePage> {
  ChuckNorrisJoke? joke;
  bool isLoading = false;

  Future<void> fetchJoke() async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse('https://api.chucknorris.io/jokes/random');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final joke = ChuckNorrisJoke(joke: data['value']);

        setState(() {
          this.joke = joke;
          isLoading = false;
        });
      } else {
        print('Failed to fetch joke');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchJoke();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chuck Norris Joke'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/chucknorris.jpg'),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      joke?.joke ?? '',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: fetchJoke,
                      child: Text('Get Another Joke'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
