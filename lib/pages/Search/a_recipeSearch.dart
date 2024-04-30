// import 'package:flutter/material.dart';
// import 'package:search_repository/search_repository.dart';

// class SearchRecipePage extends StatefulWidget {
//   const SearchRecipePage({super.key});

//   @override
//   State<SearchRecipePage> createState() => _SearchRecipePageState();
// }

// class _SearchRecipePageState extends State<SearchRecipePage> {
//   final TextEditingController _searchController = TextEditingController();
//   final RecipeApiService _apiService =
//       RecipeApiService('fd2fe20590783efd70f700efda1a10a0');

//   List<SearchRecipeModel> _searchResults = [];

//   void _searchRecipes() async {
//     final query = _searchController.text;
//     if (query.isNotEmpty) {
//       final results = await _apiService.searchRecipes(query);
//       setState(() {
//         _searchResults =
//             results.map((recipe) => SearchRecipeModel.fromMap(recipe)).toList();
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _searchController,
//               decoration: const InputDecoration(labelText: 'Enter a recipe'),
//               onSubmitted: (_) => _searchRecipes(),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _searchRecipes,
//               child: const Text('Search'),
//             ),
//             const SizedBox(height: 20),
//             Expanded(
//               child: _searchResults.isNotEmpty
//                   ? ListView.builder(
//                       physics: const ScrollPhysics(),
//                       shrinkWrap: true,
//                       itemCount: _searchResults.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 12,
//                             vertical: 12,
//                           ),
//                           child: GestureDetector(
//                             onTap: () => Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => SearchRecipeDetail(
//                                   recipeModel: _searchResults[index],
//                                 ),
//                               ),
//                             ),
//                             child: SearchRecipeCard(
//                               _searchResults[index],
//                             ),
//                           ),
//                         );
//                       },
//                     )
//                   : const Center(
//                       child: Text('No recipes found.'),
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SearchRecipeCard extends StatefulWidget {
//   final SearchRecipeModel recipeModel;
//   const SearchRecipeCard(this.recipeModel, {super.key});

//   @override
//   State<SearchRecipeCard> createState() => _SearchRecipeCardState();
// }

// class _SearchRecipeCardState extends State<SearchRecipeCard> {

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Stack(
//           children: [
//             Align(
//               alignment: Alignment.topCenter,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(24),
//                 child: Hero(
//                   tag: widget.recipeModel.image,
//                   child: Image(
//                     height: 350,
//                     width: 350,
//                     fit: BoxFit.cover,
//                     image: NetworkImage(widget.recipeModel.image),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 33,
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Flexible(
//                 flex: 2,
//                 child: Column(
//                   children: [
//                     Text(
//                       widget.recipeModel.title.toUpperCase(),
//                       style: Theme.of(context).textTheme.titleMedium,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }