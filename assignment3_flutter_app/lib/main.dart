import 'dart:convert';
import 'package:assignment3_flutter_app/calculator_page.dart';
import 'package:assignment3_flutter_app/notes_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue, // Set AppBar background color here
        ),
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
          headline2: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: Colors.black87,
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {

  String imageUrl = 'https://picsum.photos/300/400';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome',
              style: Theme.of(context).textTheme.headline1,
            ),
            Text(
              'to your Lifestyle App',
              style: Theme.of(context).textTheme.headline1,
            ),
            const SizedBox(height: 20),
            Image.network(
              imageUrl,
              height: 200,
              width: 200,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GreetingsPage()),
                );
              },
              child: Text('Get your daily Greetings'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotesPage()),
                );
              },
              child: Text('Update your daily notes'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Calculator()),
                );
              },
              child: Text('Calculate your expenses'),
            ),
            const SizedBox(height: 10),
            Text(
              'Team Members',
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
            const SizedBox(height: 10),
            Text(
              'Dharini',
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
            const SizedBox(height: 5),
            Text(
              'Nancy',
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
            const SizedBox(height: 5),
            Text(
              'Ramkumar',
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class GreetingsPage extends StatefulWidget {
  @override
  _GreetingsPageState createState() => _GreetingsPageState();
}

class _GreetingsPageState extends State<GreetingsPage> {
  String quote = 'Loading...';
  String imageUrl = 'https://picsum.photos/300/400';

  @override
  void initState() {
    super.initState();
    fetchGreetings();
  }

  Future<void> fetchGreetings() async {
    final quoteResponse =
        await http.get(Uri.parse('https://api.quotable.io/random'));
    if (quoteResponse.statusCode == 200) {
      final quoteData = json.decode(quoteResponse.body);
      setState(() {
        quote = quoteData['content'];
      });
    } else {
      throw Exception('Failed to load quote');
    }

    // Fetch random image
    final imageResponse =
        await http.get(Uri.parse('https://picsum.photos/200'));
    if (imageResponse.statusCode == 200) {
      setState(() {
        imageUrl = imageResponse.request!.url.toString();
      });
    } else {
      throw Exception('Failed to load image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Greetings Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Quote of the Day',
              style: Theme.of(context).textTheme.headline1,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                quote,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Image.network(
              imageUrl,
              height: 300,
              width: 300,
            ),
          ],
        ),
      ),
    );
  }
}
