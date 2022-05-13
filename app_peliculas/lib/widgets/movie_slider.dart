import 'package:app_peliculas/models/models.dart';
import 'package:flutter/material.dart';

class MovieSlider extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

   
  const MovieSlider({
    Key? key, 
    required this.movies,
    this.title, 
    required this.onNextPage
    }) : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      
      if(scrollController.position.pixels >= (scrollController.position.maxScrollExtent-500)){
        widget.onNextPage();
      }

    });
    
  }
  @override
  void dispose() {
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 270,
     // color: Colors.blue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          if(widget.title != null)
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(widget.title!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ),


          const SizedBox(height: 5),
          Expanded(// se usa para establecer el tamaño restante en un nuevo widget de acuerdo al tamaño del padre
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length ,
              itemBuilder: (_, index){
                return _MoviePoster(movie: widget.movies[index], heroid: '${widget.title}-${index}-${widget.movies[index].id}',);
              }
              ),
          )
         
        ],
      ),

    );
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie movie;
  final String heroid;

  const _MoviePoster({
    Key? key, 
    required this.movie, required this.heroid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    movie.heroid = heroid;
    return Container(
      width: 130,
      height: 190,
      //color: Colors.yellow,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [

          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero(
              tag: movie.heroid!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'), 
                  image: NetworkImage(movie.fullPosterImg),
                  width: 130,
                  height: 190,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5,),
          Text(
            movie.title, 
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          )
      ]),
    );
  }
}