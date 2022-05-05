import 'package:flutter/material.dart';

Size screenSize(BuildContext context) => MediaQuery.of(context).size;

double screenWidth(BuildContext context) => screenSize(context).width;

double screenHeight(BuildContext context) => screenSize(context).height;

// To get the usable screen height
double usableScreenHeight(BuildContext context) =>
    screenHeight(context) - MediaQuery.of(context).padding.top - kToolbarHeight;
