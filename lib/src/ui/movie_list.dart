import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../blocs/movies_bloc.dart';

class MovieList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    bloc.fetchAllMovies();
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: StreamBuilder(
        stream: bloc.allMovies,
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
          if (snapshot.hasData) {

            return buildList(snapshot);

          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<ItemModel> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data.results.length,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {



          return new GridTile(
//            footer: new Text(snapshot.data.results[index].original_title,
//              style: TextStyle(
//              fontSize: 18.0,
//              color: Colors.green,
//              fontWeight: FontWeight.bold)
//          ),

            footer: GestureDetector(
              child: GridTileBar(
                title: _GridTitleText(snapshot.data.results[index].original_title),
                backgroundColor: Colors.black45,

              ),
            ),

            child: new Image.network('https://image.tmdb.org/t/p/w185${snapshot.data
                .results[index].poster_path}', fit: BoxFit.cover),



             // return new Text(snapshot.data.results[index].original_title);
          );



//          return Image.network(
//            'https://image.tmdb.org/t/p/w185${snapshot.data
//                .results[index].poster_path}',
//            fit: BoxFit.cover,
//          );

        });

  }


}
class _GridTitleText extends StatelessWidget {
  const _GridTitleText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(8.0),
        alignment: Alignment.centerLeft,
      child: Text(text, style: TextStyle(
              fontSize: 18.0,
              color: Colors.green,
              fontWeight: FontWeight.bold))
    );
  }
}