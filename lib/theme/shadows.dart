import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyShadowStyle{

  static final verticalShadowStyle=BoxShadow(
    color: Colors.black54.withOpacity(0.1),
    offset: const Offset(0, 2),
    blurRadius: 15,
    spreadRadius:7,
  );

  static final horizontalShadowStyle=BoxShadow(
    color: Colors.black54.withOpacity(0.1),
    offset: const Offset(0, 2),
    blurRadius: 15,
    spreadRadius:7,
  );

  static final onboardingShadowStyle=BoxShadow(
    color: Colors.black.withOpacity(0.5),
    offset: const Offset(0, 10),
    blurRadius: 15,
    spreadRadius: 2,
  );
}