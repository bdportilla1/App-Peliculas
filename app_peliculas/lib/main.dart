import 'package:app_peliculas/providers/movies_provider.dart';
import 'package:flutter/material.dart';


import 'package:app_peliculas/screens/screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());


// Para incluir providers diferentes servicios
class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      
      providers: [
        ChangeNotifierProvider(create: (_) => MoviesProvider(), lazy: false,),// se usa false para crear al momento de lanzar la app
      ],
      child: MyApp(),);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas App',
      initialRoute: 'home',
      routes: {
        'home': ( _ ) => HomeScreen(),
        'details': ( _ ) => DetailScreen(),
      },
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          color:Color.fromRGBO(0, 65, 112, 1)
        )
      ),


    );
  }
}