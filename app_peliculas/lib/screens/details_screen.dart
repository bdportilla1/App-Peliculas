import 'package:app_peliculas/models/models.dart';
import 'package:app_peliculas/widgets/widgets.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({Key? key}) : super(key: key);

 
  @override
  Widget build(BuildContext context) {

    // capturando el objeto para presentar en el detalle
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;// tratar cmomo si fuera la clase
    print(movie.title);

    return  Scaffold(
      body: CustomScrollView(
        slivers:[
          _CustomAppBar(movie: movie),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterTitle(movie: movie),
              const _Overwiew(),
              const _Overwiew(),
              const _Overwiew(),
              CastingCard(movieId: movie.id),
            ]
            ))
         
        ]
      )
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Movie movie;
  
  const _CustomAppBar({Key? key,required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true, // para que deje de moverse arriba
      flexibleSpace:  FlexibleSpaceBar(
        centerTitle: true,
        title: Container(
          padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
          width: double.infinity,
          child:  Text(
            movie.title, 
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
            
            )
        ),
        background:  FadeInImage(

          placeholder: const AssetImage('assets/loading.gif'), 
          image: NetworkImage(movie.fullBackPosterImg),
          fit: BoxFit.cover,
        )
        
      ),
    );
  }
}

class _PosterTitle extends StatelessWidget {
   final Movie movie;

  const _PosterTitle({
    Key? key, 
    required this.movie
    }) : super(key: key);
 


  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme; // obteneer el tema
    final size = MediaQuery.of(context).size;


    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: movie.heroid!,
            child: ClipRRect(// tarjetas redondeadas
              borderRadius: BorderRadius.circular(20),
              child:  FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                height: 150,
                ),
            ),
          ),
          const SizedBox(width: 20,),

          // Se agrupa la columna del texto para evitar desbordamiento
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width-190),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title, style: textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2,),
                Text('Lenguaje original: ${movie.originalLanguage}', style: textTheme.subtitle1, overflow: TextOverflow.ellipsis, maxLines: 2,),
                Row( 
                  children: [
                    const Icon(Icons.star_border_purple500, size: 15,),
                    const SizedBox(width: 5,),
                    Text('${movie.voteAverage}', style: textTheme.caption, overflow: TextOverflow.ellipsis, maxLines: 2,),
               
                  ],
                )
          
            ],),
          )

      ]),

    );
  }
}

class _Overwiew extends StatelessWidget {
  const _Overwiew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Text('Consectetur laboris exercitation cillum ipsum sunt. Ex elit do velit mollit consectetur do mollit ullamco in et id cillum. Consectetur laboris exercitation cillum ipsum sunt. Ex elit do velit mollit consectetur do mollit ullamco in et id cillum. Consectetur laboris exercitation cillum ipsum sunt. Ex elit do velit mollit consectetur do mollit ullamco in et id cillum.',
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,),
    );
  }
}


