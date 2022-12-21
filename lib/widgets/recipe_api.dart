import 'dart:convert';

import 'package:apidemo/widgets/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeApi {
  static Future<List<Recipe>> getRecipe() async {
    var uri = Uri.https(
      'yummly2.p.rapidapi.com',
      '/feeds/list',
      {
        "limit": "23",
        "start": "0",
        "tag": "list.recipe.popular",
      },
    );
    final response = await http.get(
      uri,
      headers: {
        'X-RapidAPI-Key': '52da2f9918msha1289bc9587d0e9p14bd67jsn15aa621a8d85',
        'X-RapidAPI-Host': 'yummly2.p.rapidapi.com'
      },
    );
    print(response.body);
    Map data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data['feed']) {
      _temp.add(i['content']['details']);
    }

    return Recipe.resipeFromSnapshot(_temp);
  }
}
