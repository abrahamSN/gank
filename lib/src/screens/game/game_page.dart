import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeleton_text/skeleton_text.dart';

import '../../blocs/blocs.dart';
import '../../models/models.dart';
import '../../widgets/widgets.dart';

class GamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    return CustomScrollView(
      slivers: [
        _appBar(),
        _listCocktail(media),
      ],
    );
  }

  Widget _appBar() {
    return SliverAppBar(
      centerTitle: true,
      title: Text(
        'Ganknow.',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
          color: Colors.white,
          fontStyle: FontStyle.italic,
        ),
      ),
      primary: true,
      pinned: true,
      floating: true,
    );
  }

  Widget _listCocktail(MediaQueryData media) {
    return BlocListener<GameBloc, GameState>(
      listener: (context, state) {
        if (state is GameFetchFailure) {
          print(state.error.toString());

          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          int _count = 10;

          if (state is GameFetchSuccess) {
            _count = state.cocktailModel.drinks.length;
          }

          return SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 10.0,
            ),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    media.orientation == Orientation.portrait ? 2 : 4,
              ),
              delegate: SliverChildBuilderDelegate(
                // ignore: missing_return
                (BuildContext context, int index) {
                  if (state is GameFetchLoading) {
                    return SkeletonAnimation(
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                        ),
                      ),
                    );
                  }

                  if (state is GameFetchSuccess) {
                    final DrinkModel drinkModel =
                        state.cocktailModel.drinks[index];
                    return DrinkContainer(
                      model: drinkModel,
                    );
                  }
                },
                childCount: _count,
              ),
            ),
          );
        },
      ),
    );
  }
}
