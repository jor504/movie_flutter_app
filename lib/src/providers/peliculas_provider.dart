import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PeliculasProvider{

  String _apikey = '96afc4a4c4af92f9df82f6df744a0d82';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  
 Future<List<Pelicula>> getEnCines() async {
   
   final url = Uri.https(_url, 
    '3/movie/now_playing',
    {
     'api_key' : _apikey,
     'language' :_language
   })
   ;
   
    //Se guarda con await para que no guarde el future si no el resultado
   final resp = await http.get( url ) ;

   final decodedData = json.decode(resp.body);

   final peliculas = new Peliculas.fromJsonList(decodedData['results']);

  

   return peliculas.items;
   
  

  }



}