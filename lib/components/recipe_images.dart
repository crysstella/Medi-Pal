//image component
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class RecipeImageComponent extends StatelessWidget {
  final image;
  const RecipeImageComponent({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     double  height = 300;
     double width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      child:  Image(
        fit: BoxFit.cover,
        image: NetworkImage(
          image
        ),
        loadingBuilder: (context, child, loading){

          if(loading==null){
            return child;
          }
          else{
            return Container(
              height: height,
                width: width,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
            );
          }
        },
        errorBuilder:(context, exception, stac) {
          return Container(
            height:  height,
            width: width,
            child: Column(
              mainAxisAlignment:  MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(UniconsLine.wifi_slash),
                Text('no connection')
              ],
            ),
          );
        },
      ),



    );
  }
}