import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  
  final List<Pelicula> peliculas;
  final Function siguientePagina;
  
  MovieHorizontal ({@required this.peliculas, @required this.siguientePagina});
  final _pageController = new PageController(
          initialPage: 1, //Con cual inicia
          viewportFraction: 0.3 //Cuantas tarjetas se miran en el pave view
          );

  @override
  Widget build(BuildContext context) {

    final _sceenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent-200){
        
        siguientePagina();

      }

    });


    return Container(
      height: _sceenSize.height * 0.2,

      //Lista scroleable horizontal
      child: PageView.builder( //Son creados bajo demanda , para no tener un eror de memoria
          itemBuilder: ( context, i ) { //El pageview Builder ocupa el elemento itemBuilder , que es basicamente lo que voy a renderizar
            return _tarjeta(context, peliculas[i]); 
          },
          itemCount: peliculas.length,
          controller: _pageController,
          pageSnapping: false,
          //children: _tarjetas(context),
      ),
    );

  }

  //Se creo metodo en donde se crea una tarjeta individual
  Widget _tarjeta(BuildContext context,Pelicula pelicula){

    final tarjeta =   Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
                          child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'), 
                image: NetworkImage(pelicula.getPosterIMG()),
                fit : BoxFit.cover,
                height: 140.0,
                ),
            ),
            SizedBox(height: 10.0,),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
              ),
          ],
        ),
      );

    return GestureDetector(
      onTap: (){
        print('Titulo de la pelicula ${pelicula.title} ');
        Navigator.pushNamed(context, 'detalle',arguments: pelicula);
      },
      child: tarjeta,
    );
  }

  List<Widget> _tarjetas(BuildContext context) {

    return peliculas.map((pelicula) {
      return  Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
                          child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'), 
                image: NetworkImage(pelicula.getPosterIMG()),
                fit : BoxFit.cover,
                height: 140.0,
                ),
            ),
            SizedBox(height: 10.0,),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
              ),
          ],
        ),
      );
    }).toList();



  }



}