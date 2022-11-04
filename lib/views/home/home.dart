import 'package:fire_cars/shared-ui/carList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'addCarSection.dart';
import 'homeAppBar.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final _user = Provider.of<User?>(context);
    
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            HomeAppBar(user:_user),
            AddCarSection(user: _user),
            CarList(userID: _user!.uid),
          ],
        )
         )
    );
  }
}