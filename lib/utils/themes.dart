import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//final textTheme = Theme.of(context).textTheme;

// style: Theme.of(context).textTheme.headline6,
// style: H6,
// style: Theme.of(context).textTheme.headline6.copyWith(color: Theme.of(context).primaryColor),


var lightTheme = ThemeData(
// Define the default brightness and colors.
  brightness: Brightness.light,
  primaryColor: Colors.yellow[800],
  accentColor: Colors.red[600],

// Define the default font family.
  fontFamily: 'Georgia',

// Define the default TextTheme. Use this to specify the default
// text styling for headlines, titles, bodies of text, and more.
//textTheme: GoogleFonts.galadaTextTheme(textTheme).copyWith(
//headline6: GoogleFonts.oswald(textStyle: textTheme.headline6),
//headline5: GoogleFonts.oswald(textStyle: textTheme.headline6, fontSize: 15),

  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
    bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
  ),
);

var darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.red[800],
  accentColor: Colors.cyan[600],
  fontFamily: 'Pacifico',
);

