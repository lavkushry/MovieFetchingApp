import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/company_info_dialog.dart';
import '../widgets/movie_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _movies = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  Future<void> _fetchMovies() async {
    final response = await http.post(
      Uri.parse('https://hoblist.com/api/movieList'),
      body: {
        'category': 'movies',
        'language': 'kannada',
        'genre': 'all',
        'sort': 'voting',
      },
    );
    if (response.statusCode == 200) {
      setState(() {
        _movies = json.decode(response.body)['result'];
        _isLoading = false;
      });
      print(_movies);
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load movies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Company Info') {
                showDialog(
                  context: context,
                  builder: (context) => CompanyInfoDialog(),
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'Company Info',
                child: Text('Company Info'),
              ),
            ],
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _movies.length,
              itemBuilder: (context, index) {
                return MovieCard(movie: _movies[index]);
              },
            ),
    );
  }
}
