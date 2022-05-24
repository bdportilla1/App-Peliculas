import 'package:app_peliculas/models/movie.dart';
import 'package:app_peliculas/providers/movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieSearhDelegate extends SearchDelegate{

  @override
  String get searchFieldLabel => 'Busca tu película';
  

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query='';

      },),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
     return 
     IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: (){
          close(context, null);

        }
      );
  }

  @override
  Widget buildResults(BuildContext context) {
     return Text('build results');
  }

  Widget _emptyContainer(){
    return Container(
        child: const Center(
          child: Icon(
            Icons.movie_creation_outlined, 
            color: Colors.black,
            size: 100,
            ) 
          ),
      );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty){
      return _emptyContainer();
    }
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    return FutureBuilder(
      future: moviesProvider.searchMovies(query),
      builder: (_, AsyncSnapshot<List<Movie>> snapshot){
        
        if(!snapshot.hasData) return _emptyContainer();

        
        
        final movies = snapshot.data!;
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (_, int index) => _MovieItem(movie: movies[index])
        );
      },
    );
  }
}

class _MovieItem extends StatelessWidget {

  final Movie movie;


  const _MovieItem({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    movie.heroid = 'search-${movie.heroid}';
    return ListTile(
      leading: Hero(
        tag: movie.id,
        child: FadeInImage(
          placeholder: const AssetImage('assets/no-image.jpg'),
          image: NetworkImage(movie.fullPosterImg),
          width: 50,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: (){
        Navigator.pushNamed(context, 'details', arguments: movie);
      },
    );
  }
}