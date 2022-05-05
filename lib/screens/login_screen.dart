import 'package:flutter/material.dart';
import 'package:hibye/constants.dart';
import 'package:hibye/model/user.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kAppBackgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'HiBye',
                style: kGreetingStyle,
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton.icon(
                icon: FaIcon(FontAwesomeIcons.google),
                onPressed: () async {
                  final signInProvider =
                      Provider.of<User>(context, listen: false);
                  // TODO: Add Circular Progress Indicator
                  await signInProvider.googleLogin();
                  print(signInProvider.googleSignIn.currentUser);
                  Navigator.pushNamed(context, 'main_screen');
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                  padding: EdgeInsets.all(20.0),
                ),
                label: Text(
                  'Login with Google',
                  style: kSectionTitleSyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
