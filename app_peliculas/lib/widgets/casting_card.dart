import 'package:flutter/material.dart';

class CastingCard extends StatelessWidget {
   
  const CastingCard({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      color: Colors.red,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, int index){
          return const _CastCard() ;
        }
        ),

    );

  }
}

class _CastCard extends StatelessWidget {
  const _CastCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: 110,
      height: 100,
      color: Colors.blue,
      child:  Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage('http://via.placeholder.com/150X300'),
              height: 120,
              width: 100,
              fit: BoxFit.cover,
            )
          ),
          const SizedBox(height: 5,),
          const Text('actor.name dsa dsa dsa', 
            maxLines: 2, 
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,)
        ],
      ),

    );
  }
}



