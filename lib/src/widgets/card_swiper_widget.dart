import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
  
  final List<Pelicula> peliculas;

  //La lista es obligatoria para crear el CardSwiper
  CardSwiper({@required this.peliculas}); 

  @override
  Widget build(BuildContext context) {
    //MediaQuery para dar tamano a las tarjetas segun el dispositivo

    final _screenSize = MediaQuery.of(context).size;



    return Container(
      padding: EdgeInsets.only(top:10.0),
      child: Swiper(
          itemBuilder: (BuildContext context,int index){
            return ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(peliculas[index].getPosterIMG()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit : BoxFit.cover
                )
            );
          },
          itemCount: peliculas.length,
          itemWidth: _screenSize.width * 0.7,
          itemHeight: _screenSize.height * 0.6,
          layout: SwiperLayout.STACK,
        
          //pagination: new SwiperPagination(),
          //control: new SwiperControl(),
        ),
    );



  }
}