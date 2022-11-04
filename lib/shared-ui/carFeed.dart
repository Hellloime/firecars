import 'package:flutter/material.dart';

import '../model/carModel.dart';

class CarFeed extends StatelessWidget {
  final Car? car;
  final String? userID;
  const CarFeed({this.car, this.userID});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(car!.carUrlImg!),
          ),
      ),
    );
  }
}
