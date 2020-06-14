import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class PeliculasProvider{

  String _apikey = '96afc4a4c4af92f9df82f6df744a0d82';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularesPage = 0 ;
  bool _cargando     = false;

  List<Pelicula> _populares = new List();

  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast(); //Broadcast para que se escuche en muchos lugares.

  Function(List<Pelicula>)get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams(){
    _popularesStreamController?.close();
  }



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

    //Comprueba la primera vez siempre returnara null
    if(_cargando) return[];

    //En el segundo llamado ya no retorna null 
    _cargando = true;
    
    _popularesPage++;

   final url = Uri.https(_url, 
    '3/movie/popular',
    {
     'api_key' : _apikey,
     'language' :_language,
     'page' : _popularesPage.toString()
   })
   ;
   
    final resp =  await _procesarRespuesta(url);

    _populares.addAll(resp);
    popularesSink(_populares);

    //Ya con la respuesta se devuelve a false
    _cargando =false;
    return resp;

  }

  Future<List<Actor>> getCast(String peliId) async {

    final url = Uri.https(_url, '3/movie/$peliId/credits',{
      'api_key' : _apikey,
     'language' :_language,
    });
  
    final resp = await http.get(url);

    final decodedData = json.decode(resp.body);
  
    final cast = new Cast.fromJsonList(decodedData['cast']);
  
    return  cast.actores;
  }




}