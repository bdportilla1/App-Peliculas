
import 'package:app_peliculas/widgets/widgets.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({Key? key}) : super(key: key);

 
  @override
  Widget build(BuildContext context) {
    final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';

    return  Scaffold(
      body: CustomScrollView(
        slivers:[
          const _CustomAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              const _PosterTitle(),
              const _Overwiew(),
              const _Overwiew(),
              const _Overwiew(),
              const CastingCard(),
            ]
            ))
         
        ]
      )
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  
  const _CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true, // para que deje de moverse arriba
      flexibleSpace:  FlexibleSpaceBar(
        centerTitle: true,
        title: SizedBox(
          
          width: double.infinity,
          child:  Text(
            'movie.title', 
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
            )
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'), 
          image: NetworkImage('http://via.placeholder.com/500x300'),
          fit: BoxFit.cover,
        )
        
      ),
    );
  }
}

class _PosterTitle extends StatelessWidget {
  const _PosterTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme; // obteneer el tema


    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(// tarjetas redondeadas
            borderRadius: BorderRadius.circular(20),
            child: const FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage('http://via.placeholder.com/300x400'),
              height: 150,
              ),
          ),
          const SizedBox(width: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('movie.title 1', style: textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2,),
              Text('.title 2', style: textTheme.subtitle1, overflow: TextOverflow.ellipsis, maxLines: 2,),
              Row( 
                children: [
                  const Icon(Icons.star_border_purple500, size: 15,),
                  const SizedBox(width: 5,),
                  Text('movie.valoration', style: textTheme.caption, overflow: TextOverflow.ellipsis, maxLines: 2,),
             
                ],
              )

          ],)

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


