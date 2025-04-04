import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:learning_flutter/src/models/popular_model.dart';

class PopularDetailsScreen extends StatefulWidget {
  const PopularDetailsScreen({super.key});

  @override
  State<PopularDetailsScreen> createState() => _PopularDetailsScreenState();
}

class _PopularDetailsScreenState extends State<PopularDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final popularMovie =
        ModalRoute.of(context)!.settings.arguments as PopularModel;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              _buildMovieHeader(popularMovie),
              _buildMovieOverview(popularMovie),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMovieHeader(PopularModel popularMovie) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        _buildMoviePoster(popularMovie.posterPath),
        Positioned(top: 0, left: 0, right: 0, child: _buildTopBar()),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: _buildMovieTitle(popularMovie),
        ),
      ],
    );
  }

  Widget _buildMoviePoster(String posterPath) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://image.tmdb.org/t/p/w500/$posterPath'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildIconButton(
            icon: Icons.arrow_back,
            onPressed: () => Navigator.pop(context),
          ),
          _buildIconButton(
            icon: Icons.turned_in,
            onPressed: () {},
            iconColor: Colors.amber,
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onPressed,
    Color iconColor = Colors.white,
  }) {
    return IconButton.filledTonal(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll<Color>(
          Colors.black.withValues(alpha: 0.5),
        ),
      ),
      icon: Icon(icon, color: iconColor),
    );
  }

  Widget _buildMovieTitle(PopularModel popularMovie) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  popularMovie.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                _buildRatingRow(popularMovie),
              ],
            ),
          ),
          IconButton.filledTonal(
            onPressed: () {},
            padding: const EdgeInsets.all(15),
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll<Color>(
                Colors.black.withValues(alpha: 0.5),
              ),
            ),
            icon: Icon(Icons.play_arrow, color: Colors.white, size: 35),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingRow(PopularModel popularMovie) {
    return Row(
      children: [
        Text(
          popularMovie.voteAverage.toStringAsFixed(1),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(width: 10),
        RatingBar.builder(
          initialRating: popularMovie.voteAverage / 2,
          minRating: 1,
          direction: Axis.horizontal,
          ignoreGestures: true,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 25,
          unratedColor: Colors.white,
          itemBuilder:
              (context, _) =>
                  const Icon(Icons.star_rounded, color: Colors.amber),
          onRatingUpdate: (rating) {},
        ),
      ],
    );
  }

  Widget _buildMovieOverview(PopularModel popularMovie) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Overview',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Text(
            popularMovie.overview,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}
