import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../blocs/blocs.dart';
import '../../models/models.dart';
import '../../utils/utils.dart';

class DrinkDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    // final bloc = ExploreProvider.of(context);
    Map args = ModalRoute.of(context).settings.arguments;
    DrinkModel model = args['model'];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _appBar(media, model),
          _ingredients(model),
          _instructions(model),
          _serve(model),
        ],
      ),
    );
  }

  Widget _appBar(MediaQueryData media, DrinkModel model) {
    return SliverAppBar(
      expandedHeight: media.orientation == Orientation.portrait ? 400.0 : 200.0,
      title: Hero(
        tag: '${model.strDrink}',
        child: Text('${model.strDrink}'),
      ),
      flexibleSpace: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Hero(
              tag: '${model.strDrinkThumb}',
              child: CachedNetworkImage(
                imageUrl: model.strDrinkThumb,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black26,
                  Colors.transparent,
                  Colors.black26,
                ],
              ),
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
          Positioned(
            bottom: 10.0,
            left: 15.0,
            right: 8.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                model.strTags != null
                    ? Text(
                  '${model.strTags}',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
                    : SizedBox.shrink(),
                Text(
                  '${model.strCategory}',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${model.strAlcoholic}',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          model.strVideo != null
              ? Align(
            alignment: Alignment.center,
            child: FlatButton.icon(
              icon: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 50.0,
              ),
              label: Text(
                'Play the video.',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.black54,
              onPressed: () {
                // bloc.launchYt(model.strVideo);
              },
            ),
          )
              : SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _ingredients(DrinkModel model) {
    return SliverPadding(
      padding: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        top: 15.0,
        bottom: 5.0,
      ),
      sliver: SliverToBoxAdapter(
        child: Card(
          color: AppTheme().SECONDARY_COLOR,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ingredients',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                model.strIngredient1 != null
                    ? Row(
                  children: [
                    Text(
                      '${model.strIngredient1} ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: Divider(),
                    ),
                    Text(
                      ' ${model.strMeasure1}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
                    : SizedBox.shrink(),
                model.strIngredient2 != null
                    ? Row(
                  children: [
                    Text(
                      '${model.strIngredient2} ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: Divider(),
                    ),
                    Text(
                      ' ${model.strMeasure2}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
                    : SizedBox.shrink(),
                model.strIngredient3 != null
                    ? Row(
                  children: [
                    Text(
                      '${model.strIngredient3} ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: Divider(),
                    ),
                    Text(
                      ' ${model.strMeasure3}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
                    : SizedBox.shrink(),
                model.strIngredient4 != null
                    ? Row(
                  children: [
                    Text(
                      '${model.strIngredient4} ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: Divider(),
                    ),
                    Text(
                      ' ${model.strMeasure4}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
                    : SizedBox.shrink(),
                model.strIngredient5 != null
                    ? Row(
                  children: [
                    Text(
                      '${model.strIngredient5} ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: Divider(),
                    ),
                    Text(
                      '${model.strMeasure5} ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
                    : SizedBox.shrink(),
                model.strIngredient6 != null
                    ? Row(
                  children: [
                    Text(
                      '${model.strIngredient6} ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: Divider(),
                    ),
                    Text(
                      '${model.strMeasure6} ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
                    : SizedBox.shrink(),
                model.strIngredient7 != null
                    ? Row(
                  children: [
                    Text(
                      '${model.strIngredient7} ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: Divider(),
                    ),
                    Text(
                      '${model.strMeasure7} ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
                    : SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _instructions(DrinkModel model) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5.0,
      ),
      sliver: SliverToBoxAdapter(
        child: Card(
          color: AppTheme().SECONDARY_COLOR,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Instructions',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  '${model.strInstructions}',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _serve(DrinkModel model) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5.0,
      ),
      sliver: SliverToBoxAdapter(
        child: Card(
          color: AppTheme().SECONDARY_COLOR,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Serve it with',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  '${model.strGlass}',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
