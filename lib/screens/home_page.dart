import 'package:apidemo/utils/recipe_card.dart';
import 'package:apidemo/widgets/recipe.dart';
import 'package:apidemo/widgets/recipe_api.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Recipe>? _recipe;
  bool isLoading = true;

  @override
  void initState() {
    getR();
    super.initState();
  }

  Future<void> getR() async {
    _recipe = await RecipeApi.getRecipe();
    setState(() {
      isLoading = false;
    });
    // print(_recipe);
  }

  @override
  Widget build(BuildContext context) {
    getR();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.restaurant_menu,
                color: Colors.black,
              ),
              SizedBox(width: 10),
              Text(
                'Food Recipes',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: 23,
                itemBuilder: (context, index) {
                  return RecipeCard(
                    title: _recipe![index].name,
                    cookTime: _recipe![index].totalTime,
                    rating: _recipe![index].rating.toString(),
                    thumbnailUrl: _recipe![index].images,
                  );
                },
              )
        // body: FutureBuilder(
        //   future: getR(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.done) {
        //       return ListView.builder(
        //         itemBuilder: (context, index) {
        //           return RecipeCard(
        //             title: _recipe![index].name,
        //             cookTime: _recipe![index].totalTime,
        //             rating: _recipe![index].rating.toString(),
        //             thumbnailUrl: _recipe![index].images,
        //           );
        //         },
        //       );
        //     }
        //   },
        // ),
        );
  }
}
