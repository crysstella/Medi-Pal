import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:search_repository/search_repository.dart';

// class Ingredients extends StatefulWidget {
//   final RecipeModel recipeModel;
//   const Ingredients({required this.recipeModel, super.key});

//   @override
//   State<Ingredients> createState() => _IngredientsState();
// }

// class _IngredientsState extends State<Ingredients> {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           const SizedBox(
//             height: 20,
//           ),
//           ListView.separated(
//             physics: const ScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: widget.recipeModel.ingredients.length,
//             separatorBuilder: (BuildContext context, int index) {
//               return Divider(
//                 color: Colors.black.withOpacity(0.3),
//               );
//             },
//             itemBuilder: (BuildContext context, int index) {
//               return Row(
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       setState(() {
//                         widget.recipeModel.takedingredients[index] =
//                             !widget.recipeModel.takedingredients[index];
//                       });
//                     },
//                     child: Icon(
//                       widget.recipeModel.takedingredients[index]
//                           ? Icons.task_alt
//                           : Icons.circle_outlined,
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   Expanded(
//                     child: Text(
//                       widget.recipeModel.ingredients[index],
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class Preparation extends StatelessWidget {
//   final RecipeModel recipeModel;
//   const Preparation({required this.recipeModel, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           const SizedBox(
//             height: 20,
//           ),
//           ListView.separated(
//             physics: const ScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: recipeModel.preparation.length,
//             separatorBuilder: (BuildContext context, int index) {
//               return Divider(
//                 color: Colors.black.withOpacity(0.3),
//               );
//             },
//             itemBuilder: (BuildContext context, int index) {
//               return Row(
//                 children: [
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   Expanded(
//                     child: (recipeModel.preparation[index].startsWith('-'))
//                         ? Text(
//                             recipeModel.preparation[index],
//                             style: const TextStyle(fontSize: 14),
//                             softWrap: true,
//                           )
//                         : Text(
//                             recipeModel.preparation[index],
//                             style: const TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                             softWrap: true,
//                           ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class Cooking extends StatefulWidget {
//   final RecipeModel recipeModel;
//   const Cooking({required this.recipeModel, super.key});

//   @override
//   State<Cooking> createState() => _CookingState();
// }

// class _CookingState extends State<Cooking> {
//   int lineCounter = 1;
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           const SizedBox(
//             height: 20,
//           ),
//           ListView.separated(
//             physics: const ScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: widget.recipeModel.cooking.length,
//             separatorBuilder: (BuildContext context, int index) {
//               return Divider(
//                 color: Colors.black.withOpacity(0.3),
//               );
//             },
//             itemBuilder: (BuildContext context, int index) {
//               String lineText =
//                   '$lineCounter. ${widget.recipeModel.cooking[index]}';
//               return Row(
//                 children: [
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   Expanded(
//                     child: (widget.recipeModel.cooking[index].startsWith('-'))
//                         ? Text(
//                             widget.recipeModel.cooking[index],
//                             style: const TextStyle(fontSize: 14),
//                             softWrap: true,
//                           )
//                         : (() {
//                             lineCounter++;
//                             return Text(
//                               lineText,
//                               style: const TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               softWrap: true,
//                             );
//                           })(),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

class SearchRecipeIngredients extends StatefulWidget {
  final SearchRecipeModel searchRecipeModel;
  const SearchRecipeIngredients({required this.searchRecipeModel, super.key});

  @override
  State<SearchRecipeIngredients> createState() => _SearchRecipeIngredientsState();
}

class _SearchRecipeIngredientsState extends State<SearchRecipeIngredients> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          ListView.separated(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.searchRecipeModel.ingredients.length,
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                color: Colors.black.withOpacity(0.3),
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        widget.searchRecipeModel.takedingredients[index] =
                            !widget.searchRecipeModel.takedingredients[index];
                      });
                    },
                    child: Icon(
                      widget.searchRecipeModel.takedingredients[index]
                          ? Icons.task_alt
                          : Icons.circle_outlined,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      widget.searchRecipeModel.ingredients[index],
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class SearchRecipeCooking extends StatefulWidget {
  final SearchRecipeModel searchRecipeModel;
  const SearchRecipeCooking({required this.searchRecipeModel, super.key});

  @override
  State<SearchRecipeCooking> createState() => _SearchRecipeCookingState();
}

class _SearchRecipeCookingState extends State<SearchRecipeCooking> {
  @override
  void initState() {
    if (widget.searchRecipeModel.url.contains('http://')) {
      widget.searchRecipeModel.url =
          widget.searchRecipeModel.url.replaceFirst('http://', 'https://');
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: InAppWebView(
      //   gestureRecognizers: {
      //     Factory<VerticalDragGestureRecognizer>(
      //         () => VerticalDragGestureRecognizer())
      //   },
      //   initialUrlRequest: URLRequest(
      //     url: Uri.parse(widget.edamamrecipeModel.url),
      //   ),
      //   initialOptions: InAppWebViewGroupOptions(
      //     crossPlatform: InAppWebViewOptions(),
      //   ),
      //   onWebViewCreated: (InAppWebViewController controller) {},
      // ),
    );
  }
}