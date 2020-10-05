import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../models/models.dart';
import '../utils/utils.dart';

class DrinkContainer extends StatelessWidget {
  final DrinkModel model;

  DrinkContainer({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/drink_details',
          arguments: {
            'model': model,
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(5.0),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
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
                    Colors.transparent,
                    Colors.black26,
                  ],
                ),
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
            Positioned(
              bottom: 8.0,
              left: 8.0,
              right: 8.0,
              child: Hero(
                tag: '${model.strDrink}',
                child: Text(
                  '${model.strDrink}',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
