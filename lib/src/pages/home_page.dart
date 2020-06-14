import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/search/search_delegate.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';


class HomePage extends StatelessWidget {
  
  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {

    peliculasProvider.getPopulares();

    return Scaffold(

      appBar: AppBar(
        centerTitle: false,
        title: Text('Peliculas en Cine'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search), 
            onPressed: (){
              //Buequeda
              showSearch(
                context: context, 
                delegate: DataSearch(),
                //query: 'Hola'
                );

            }
            )
        ],
      ),

      //Widget para desplegar informacion donde no esta el notch SafeArea
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            
            _swiperTarjetas(),
            _footer(context)
          ],
        ),
      )
      
      
      
      
    );
  }

  Widget _swiperTarjetas() {

    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

        if (snapshot.hasData){
          return CardSwiper(peliculas: snapshot.data);
      }
      else{
          return Container
                      (child: Center
                          (child: 
                          CircularProgressIndicator())
                      );
        }
      },
    );
  }

  Widget _footer(BuildContext context){

    return Container(
      width: double.infinity ,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('Populares',style:Theme.of(context).textTheme.subtitle2)
            ),
          SizedBox(height: 10.0,),


          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
               if (snapshot.hasData){
                     return MovieHorizontal(peliculas : snapshot.data,siguientePagina: peliculasProvider.getPopulares,);
                }
                else{
                    return Container
                                (child: Center
                                    (child: 
                                    CircularProgressIndicator())
                                );
                  }
            },
          ),
          

        ],

      ),
    );


  }


}