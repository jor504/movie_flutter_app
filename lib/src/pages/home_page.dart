import 'package:flutter/material.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';


class HomePage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: false,
        title: Text('Peliculas en Cine'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search), 
            onPressed: (){

            }
            )
        ],
      ),

      //Widget para desplegar informacion donde no esta el notch SafeArea
      body: Container(
        child: Column(
          children: <Widget>[
            _swiperTarjetas()
          ],
        ),
      )
      
      
      
      
    );
  }

  Widget _swiperTarjetas() {

    return  CardSwiper(peliculas: [1]);


  }
}