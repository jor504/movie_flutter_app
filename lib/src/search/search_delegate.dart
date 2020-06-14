import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate{

  String seleccion = '';
  final peliculasProvider = new PeliculasProvider();

  final peliculas =[
    'Pulp Fiction',
    'Kill Bill',
    'Bastardos sin Gloria',
    'Perros de Reserva'

  ];

  final peliculasRecientes = [
    'Spiderman',
    'Capitan America'

  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    //Accciones del appbar - icono para limpiar o cancelar la buqueda
      return [
        IconButton(icon: Icon(Icons.clear), onPressed: ( ){
          //query es la variable que trae el search delegate para capturar lo que se esta escribiendo
          query='';
        })

      ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //Icono a la izquierda del appbar - icono de lupa 
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,), 
      onPressed: (){
        //close es un metodo del search delegate que lo cierra xD , result puede ser nulo
        close(
          context,
          null
          );
      }
      );
  }

  @override
  Widget buildResults(BuildContext context) {
    //Crea los resultados a mostar
    return Container();
    /*
    Center(
      child: Container(
        height : 100.0,
        width : 100.0,
        color: Colors.blueAccent,
        child: Text(seleccion),


      ),
      );*/
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Sugerencias que aparecen cuando la persona escribe
    
    if (query.isEmpty){
      return Container();
    }

    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot <List<Pelicula>> snapshot) {

        if (snapshot.hasData){
          
          final peliculas = snapshot.data;
          
          return ListView(
            children: peliculas.map((pelicula){
              return ListTile(
                leading: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'), 
                  image: NetworkImage(pelicula.getPosterIMG()),
                  width: 50.0,
                  fit: BoxFit.contain,
                  ),
                  title: Text(pelicula.title),
                  subtitle: Text(pelicula.originalTitle),
                  onTap: (){
                    close(context,null);
                    pelicula.uniqueId = '';
                    Navigator.pushNamed(context, 'detalle',arguments: pelicula);
                  },
              );
            }).toList()
          );
        }
        else{
          return Center(
            child : CircularProgressIndicator()
          );

        }


      },
    
    );


    /*
    final listaSugerida = ( query.isEmpty ) 
                            ? peliculasRecientes
                            : peliculas.where(
                              (p) => p.toLowerCase().startsWith(query.toLowerCase())
                            ).toList();
    
    return ListView.builder(
      itemCount: listaSugerida.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading : Icon(Icons.movie),
          title: Text(listaSugerida[index]),

          onTap: () {
            seleccion = listaSugerida[index];
            //showResults construye los resultados
            showResults(context);
          },

        );
      },
      );
      */
  }




}