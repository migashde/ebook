import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'single.dart';

Future<List<Book>> fetchBook(http.Client client) async {
  final response = await client.get(Uri.parse('http://192.168.0.100/ebook/'));
  return compute(parseBook, response.body);
}

List<Book> parseBook(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Book>((json) => Book.fromJson(json)).toList();
}

class Book {
  final String id;
  final String title;
  final String description;
  final String filePath;
  final String createdAt;
  final String views;

  const Book({
    required this.id,
    required this.title,
    required this.description,
    required this.filePath,
    required this.createdAt,
    required this.views,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      filePath: json['file_path'] as String,
      createdAt: json['created_at'] as String,
      views: json['views'] as String,
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ebook',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Ebook'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Book>>(
        future: fetchBook(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Ном олдсонгүй!'),
            );
          } else if (snapshot.hasData) {
            return BookList(book: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('AlertDialog Title'),
              content: const Text('AlertDialog description'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class BookList extends StatelessWidget {
  const BookList({Key? key, required this.book}) : super(key: key);

  final List<Book> book;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: book.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SingleBook(
                      title: book[index].title,
                      description: book[index].description,
                      filePath: book[index].filePath,
                      createdAt: book[index].createdAt,
                      views: book[index].views)),
            ),
          },
          child: Card(
            child: Container(
              margin: EdgeInsets.all(15.0),
              child: Text(
                book[index].title,
                style: DefaultTextStyle.of(context)
                    .style
                    .apply(fontSizeFactor: 1.4),
              ),
            ),
          ),
        );
      },
    );
  }
}
