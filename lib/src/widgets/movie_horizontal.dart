import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  
  final List<Pelicula> peliculas;
  
  MovieHorizontal ({@required this.peliculas});

  @override
  Widget build(BuildContext context) {

    final _sceenSize = MediaQuery.of(context).size;

    return Container(
      height: _sceenSize.height * 0.2,

      //Lista scroleable horizontal
      child: PageView(
        controller: PageController(
          initialPage: 1, //Con cual inicia
          viewportFraction: 0.3 //Cuantas tarjetas se miran en el pave view
          ),
          pageSnapping: false,
        children: _tarjetas(context),
      ),
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