import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learning_flutter/src/api/popular_api.dart';
import 'package:learning_flutter/src/models/popular_model.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  PopularApi? popular;

  @override
  void initState() {
    super.initState();

    popular = PopularApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Popular Movies')),
      body: _buildPopularList(),
    );
  }

  Widget _buildPopularList() {
    return FutureBuilder(
      future: popular?.getHttpPopular(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        return GridView.builder(
          padding: const EdgeInsets.all(20),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.55,
          ),
          itemCount: snapshot.data?.length,
          itemBuilder: (context, index) {
            return _popularMovieItem(snapshot.data![index]);
          },
        );
      },
    );
  }

  Widget _popularMovieItem(PopularModel popularMovie) {
    return InkWell(
      onTap:
          () => Navigator.pushNamed(
            context,
            '/popular-details',
            arguments: popularMovie,
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              image: DecorationImage(
                image: NetworkImage(
                  'https://image.tmdb.org/t/p/w500${popularMovie.posterPath}',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            popularMovie.title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(DateFormat('yyyy').format(popularMovie.releaseDate)),
        ],
      ),
    );
  }
}
