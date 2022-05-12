import 'package:app_peliculas/providers/movies_provider.dart';
import 'package:app_peliculas/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);




    return Scaffold(
      appBar: AppBar(
        title: const Text('Peliculas en cines'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search_off_outlined),
            onPressed: (){


            }, 
           )
        ],

      ),
      body: SingleChildScrollView( // permite scroll
        child: Column(
          children: [
            // las cards
            CardSwiper(movies: moviesProvider.onDisplayMovies),
            //listado peliculas
            const MovieSlider()
      
          ],
        ),
      ),
    );
  }
}