import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oureschoolweb/ui/components/color.dart';
import 'package:oureschoolweb/ui/helper/responsive_reducers.dart';

// Simple
TextStyle headlineTextStyle(BuildContext context, {Color color}) =>
    GoogleFonts.montserrat(
      textStyle: TextStyle(
        fontSize: getResponsiveExtraLargeFontSize(context),
        color: color ?? textMenuBarPrimary,
        // letterSpacing: 1.2,
        fontWeight: FontWeight.w300,
      ),
    );

TextStyle headlineSecondaryTextStyle(BuildContext context, {Color color}) =>
    GoogleFonts.montserrat(
      textStyle: TextStyle(
        fontSize: getResponsiveLargeFontSize(context),
        color: color ?? textMenuBarPrimary,
        fontWeight: FontWeight.w300,
      ),
    );

TextStyle extraLargeTextStyle(BuildContext context, {Color color}) =>
    GoogleFonts.montserrat(
      textStyle: TextStyle(
        fontSize: getResponsiveMassiveFontSize(context),
        color: color ?? textMenuBarPrimary,
        fontWeight: FontWeight.w300,
      ),
    );

TextStyle subtitleTextStyle(BuildContext context, {Color color}) =>
    GoogleFonts.openSans(
      textStyle: TextStyle(
        fontSize: getResponsiveSmallFontSize(context),
        color: color ?? textSecondary,
        letterSpacing: 1,
      ),
    );

TextStyle bodyTextStyle(BuildContext context, {Color color}) =>
    GoogleFonts.openSans(
      textStyle: TextStyle(
        fontSize: getResponsiveMediumFontSize(context),
        color: color ?? textMenuBarPrimary,
      ),
    );

TextStyle buttonTextStyle({Color color}) => GoogleFonts.montserrat(
      textStyle: TextStyle(
        fontSize: 18,
        color: color ?? textMenuBarPrimary,
        letterSpacing: 1,
      ),
    );

// Advanced
// TODO: Add additional text styles.
