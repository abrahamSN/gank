import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_charts/multi_charts.dart';

import '../../blocs/blocs.dart';
import '../../widgets/widgets.dart';
import '../../utils/utils.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: _bodyBuilder(context),
    );
  }

  Widget _appBar() {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      title: Text(
        "${FirebaseAuth.instance.currentUser.displayName}",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
          color: Colors.white,
          fontStyle: FontStyle.italic,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _bodyBuilder(BuildContext context) {
    return ListView(
      children: [
        _account(),
        Container(
          padding: EdgeInsets.only(top:50.0),
          child: StatusChart(),
        ),
        Container(
          padding: EdgeInsets.all(10.0),
          child: _statusChart(),
        ),
        RaisedButton(
          onPressed: () {
            context.bloc<AuthBloc>().add(LoggedOut());
          },
          child: Text('LogOut'),
        )
      ],
    );
  }

  Widget _account() {
    return Container(
      color: AppTheme().PRIMARY_COLOR,
      height: 180.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _headingContainer(title: 'FOLLOWERS', num: 323),
              CircleAvatar(
                radius: 40.0,
                child: Text("SN"),
              ),
              _headingContainer(title: 'FOLLOWING', num: 29),
            ],
          ),
          Container(
            padding: EdgeInsets.all(15.0),
            child: Text(
              "${FirebaseAuth.instance.currentUser.displayName}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.white,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.explore,
                color: Colors.green,
                size: 15.0,
              ),
              Text(
                " EXPERIENCE ",
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "0",
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _headingContainer({String title, int num}) {
    return Container(
      width: 80.0,
      height: 80.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$num',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusChart() {
    return RadarChart(
      values: [4, 5, 7, 5, 7, 8, 9],
      labels: [
        "Jungle",
        "Mid",
        "Top",
        "AD",
        "Support",
        "Support2",
        "Support",
      ],
      maxValue: 10,
      fillColor: Colors.red,
      chartRadiusFactor: 0.7,
    );
  }
}
