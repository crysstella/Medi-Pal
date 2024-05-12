import 'package:flutter/material.dart';
import 'package:search_repository/search_repository.dart';
import 'package:unicons/unicons.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'extend_detail.dart';


class SearchRecipeDetail extends StatefulWidget {
  final SearchRecipeModel searchRecipeModel;
  const SearchRecipeDetail({super.key, required this.searchRecipeModel});

  @override
  State<SearchRecipeDetail> createState() => _SearchRecipeDetailState();
}

class _SearchRecipeDetailState extends State<SearchRecipeDetail> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: SlidingUpPanel(
          minHeight: size.height / 2,
          maxHeight: size.height / 1.15,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          parallaxEnabled: true,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                // Align(
                //   alignment: Alignment.topCenter,
                //   child: Hero(
                //     tag: widget.recipeModel.image,
                //     child: Image(
                //       height: (size.height / 2) + 60,
                //       width: double.infinity,
                //       fit: BoxFit.cover,
                //       image: NetworkImage(widget.recipeModel.image),
                //     ),
                //   ),
                // ),
                Positioned(
                  top: 40,
                  left: 20,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      UniconsLine.arrow_left,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ],
            ),
          ),
          panel: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 5,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(
                        0.3,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  widget.searchRecipeModel.title,
                  style: textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.monitor_heart,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(widget.searchRecipeModel.kcal.toString()),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(Icons.timer),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(widget.searchRecipeModel.cookingTime.toString()),
                    const SizedBox(
                      width: 25,
                    ),
                    Container(
                      color: Colors.black,
                      height: 30,
                      width: 3,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(Icons.person),
                    const SizedBox(
                      width: 5,
                    ),
                    Text("${widget.searchRecipeModel.servings} Servings"),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Colors.black.withOpacity(0.3),
                ),
                Expanded(
                  child: DefaultTabController(
                    length: 2,
                    initialIndex: 0,
                    child: Column(
                      children: [
                        TabBar(
                          isScrollable: false,
                          labelColor: Colors.black,
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                          indicator: const UnderlineTabIndicator(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 4.0,
                            ),
                          ),
                          unselectedLabelColor: Colors.grey,
                          tabs: [
                            Tab(
                              text: "Ingredients".toUpperCase(),
                            ),
                            Tab(
                              text: "Cook".toUpperCase(),
                            ),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              SearchRecipeIngredients(searchRecipeModel: widget.searchRecipeModel),
                              SearchRecipeCooking(searchRecipeModel: widget.searchRecipeModel,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}