import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PeliculasProvider{

  String _apikey = '96afc4a4c4af92f9df82f6df744a0d82';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';


  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get( url ) ;
   final decodedData = json.decode(resp.body);
   final peliculasPopulares = new Peliculas.fromJsonList(decodedData['results']);
   return peliculasPopulares.items;
  }
  
 Future<List<Pelicula>> getEnCines() async {
   
   final url = Uri.https(_url, 
    '3/movie/now_playing',
    {
     'api_key' : _apikey,
     'language' :_language
   })
   ;
   
   return await _procesarRespuesta(url);
  

  }

  Future<List<Pelicula>> getPopulares() async {
   
   final url = Uri.https(_url, 
    '3/movie/popular',
    {
     'api_key' : _apikey,
     'language' :_language
   })
   ;
   
    return await _procesarRespuesta(url);
  

  }




}