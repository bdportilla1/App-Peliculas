import 'package:app_peliculas/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;
   
  const CardSwiper({
    Key? key, 
    required this.movies
    }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    // si es igual a 0 en el provider
    if(this.movies.length==0){
      return  Container(
        width: double.infinity, // poner el ancho del padre
        height: size.height*0.5,
        child: const Center(
          child: CircularProgressIndicator()),
      );
    }
    // **************************

    return Container(
      width: double.infinity, // poner el ancho del padre
      height: size.height*0.5,
      //color: Colors.red,
      child: Swiper(
        
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.width * 0.9,
        itemBuilder: (BuildContext context, int index){
          // para probar
          final movie = movies[index];
          movie.heroid = 'swiper-${movie.id}';
          //print(movie.posterPath);

          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero(
              tag: movie.heroid!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'), 
                  image: NetworkImage(movie.fullPosterImg),
                  fit: BoxFit.cover,
                  ),
              ),
            ),
          );
        },
        )
    );
  }
}