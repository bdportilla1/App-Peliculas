import 'package:app_peliculas/models/models.dart';
import 'package:app_peliculas/providers/movies_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CastingCard extends StatelessWidget {

  final int movieId;
   
  const CastingCard({Key? key, required this.movieId}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      
      future: moviesProvider.getMovieCast(movieId),
      //builder: (_, AsyncSnapshot<List<Cast>>! snapshot){
      builder: ( _, AsyncSnapshot<List<Cast>> snapshot){
        // En caso de que no traiga data se muestra un progress bar
        if (!snapshot.hasData){
          return Container(
            width: double.infinity,
            height: 180,
            //color: Colors.red,
            child: const CupertinoActivityIndicator()
          );
        } 

        final List<Cast> cast = snapshot.data!;


        return Container(
          width: double.infinity,
          height: 180,
          //color: Colors.red,
          child: ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, int index){
              return _CastCard(actor: cast[index]) ;
            }
            ),

    );

      },
    );

  }
}

class _CastCard extends StatelessWidget {
  final Cast actor;

  const _CastCard({Key? key, required this.actor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: 110,
      height: 100,
      //color: Colors.blue,
      child:  Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child:  FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(actor.fullprofilePath),
              height: 120,
              width: 100,
              fit: BoxFit.cover,
            )
          ),
          const SizedBox(height: 5,),
            Text(actor.name, 
              maxLines: 2, 
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            )
        ],
      ),

    );
  }
}



