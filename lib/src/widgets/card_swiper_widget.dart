import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  
  final List<dynamic> peliculas;

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
              child: Image.network("http://via.placeholder.com/350x150",fit: BoxFit.cover,),
            );
            
            
             
         
         
          },
          itemCount: peliculas.length,
          itemWidth: _screenSize.width * 0.7,
          itemHeight: _screenSize.height * 0.5,
          layout: SwiperLayout.STACK,
        
          //pagination: new SwiperPagination(),
          //control: new SwiperControl(),
        ),
    );



  }
}