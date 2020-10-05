class CocktailModel {
  List<DrinkModel> drinks;

  CocktailModel.fromJson(Map<String, dynamic> parsedJson) {
    drinks = List<DrinkModel>();
    parsedJson['drinks'].forEach((v) {
      drinks.add(DrinkModel.fromJson(v));
    });

  }
}

class DrinkModel {
  final String idDrink;
  final String strDrink;
  final String strDrinkAlternate;
  final String strDrinkES;
  final String strDrinkDE;
  final String strDrinkFR;
  final String strDrinkZHHANS;
  final String strDrinkZHHANT;
  final String strTags;
  final String strVideo;
  final String strCategory;
  final String strIBA;
  final String strAlcoholic;
  final String strGlass;
  final String strInstructions;
  final String strInstructionsES;
  final String strInstructionsDE;
  final String strInstructionsFR;
  final String strInstructionsZHHANS;
  final String strInstructionsZHHANT;
  final String strDrinkThumb;
  final String strIngredient1;
  final String strIngredient2;
  final String strIngredient3;
  final String strIngredient4;
  final String strIngredient5;
  final String strIngredient6;
  final String strIngredient7;
  final String strIngredient8;
  final String strIngredient9;
  final String strIngredient10;
  final String strIngredient11;
  final String strIngredient12;
  final String strIngredient13;
  final String strIngredient14;
  final String strIngredient15;
  final String strMeasure1;
  final String strMeasure2;
  final String strMeasure3;
  final String strMeasure4;
  final String strMeasure5;
  final String strMeasure6;
  final String strMeasure7;
  final String strMeasure8;
  final String strMeasure9;
  final String strMeasure10;
  final String strMeasure11;
  final String strMeasure12;
  final String strMeasure13;
  final String strMeasure14;
  final String strMeasure15;
  final String strCreativeCommonsConfirmed;
  final String dateModified;

  DrinkModel.fromJson(Map<String, dynamic> parsedJson)
      : idDrink = parsedJson['idDrink'],
        strDrink = parsedJson['strDrink'],
        strDrinkAlternate = parsedJson['strDrinkAlternate'],
        strDrinkES = parsedJson['strDrinkES'],
        strDrinkDE = parsedJson['strDrinkDE'],
        strDrinkFR = parsedJson['strDrinkFR'],
        strDrinkZHHANS = parsedJson['strDrinkZH-HANS'],
        strDrinkZHHANT = parsedJson['strDrinkZH-HANT'],
        strTags = parsedJson['strTags'],
        strVideo = parsedJson['strVideo'],
        strCategory = parsedJson['strCategory'],
        strIBA = parsedJson['strIBA'],
        strAlcoholic = parsedJson['strAlcoholic'],
        strGlass = parsedJson['strGlass'],
        strInstructions = parsedJson['strInstructions'],
        strInstructionsES = parsedJson['strInstructionsES'],
        strInstructionsDE = parsedJson['strInstructionsDE'],
        strInstructionsFR = parsedJson['strInstructionsFR'],
        strInstructionsZHHANS = parsedJson['strInstructionsZH-HANS'],
        strInstructionsZHHANT = parsedJson['strInstructionsZH-HANT'],
        strDrinkThumb = parsedJson['strDrinkThumb'],
        strIngredient1 = parsedJson['strIngredient1'],
        strIngredient2 = parsedJson['strIngredient2'],
        strIngredient3 = parsedJson['strIngredient3'],
        strIngredient4 = parsedJson['strIngredient4'],
        strIngredient5 = parsedJson['strIngredient5'],
        strIngredient6 = parsedJson['strIngredient6'],
        strIngredient7 = parsedJson['strIngredient7'],
        strIngredient8 = parsedJson['strIngredient8'],
        strIngredient9 = parsedJson['strIngredient9'],
        strIngredient10 = parsedJson['strIngredient10'],
        strIngredient11 = parsedJson['strIngredient11'],
        strIngredient12 = parsedJson['strIngredient12'],
        strIngredient13 = parsedJson['strIngredient13'],
        strIngredient14 = parsedJson['strIngredient14'],
        strIngredient15 = parsedJson['strIngredient15'],
        strMeasure1 = parsedJson['strMeasure1'],
        strMeasure2 = parsedJson['strMeasure2'],
        strMeasure3 = parsedJson['strMeasure3'],
        strMeasure4 = parsedJson['strMeasure4'],
        strMeasure5 = parsedJson['strMeasure5'],
        strMeasure6 = parsedJson['strMeasure6'],
        strMeasure7 = parsedJson['strMeasure7'],
        strMeasure8 = parsedJson['strMeasure8'],
        strMeasure9 = parsedJson['strMeasure9'],
        strMeasure10 = parsedJson['strMeasure10'],
        strMeasure11 = parsedJson['strMeasure11'],
        strMeasure12 = parsedJson['strMeasure12'],
        strMeasure13 = parsedJson['strMeasure13'],
        strMeasure14 = parsedJson['strMeasure14'],
        strMeasure15 = parsedJson['strMeasure15'],
        strCreativeCommonsConfirmed = parsedJson['strCreativeCommonsConfirmed'],
        dateModified = parsedJson['dateModified'];
}
