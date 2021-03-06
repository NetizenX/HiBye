import 'package:flutter/material.dart';
import '../constants.dart';
import '../model/user.dart';
import 'package:provider/provider.dart';

class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          Provider.of<User>(
            context,
            listen: false,
          ).googleSignOut();
          Navigator.pop(context);
        },
        child: Text(
          'Logout',
          style: kMenuItemFontStyle,
        ));
  }
}
