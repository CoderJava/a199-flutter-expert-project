import 'package:ditonton/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  test(
    'make sure kSubtitle value',
    () async {
      // assert
      expect(
        kSubtitle,
        GoogleFonts.poppins(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.15,
        ),
      );
    },
  );

  test(
    'make sure kBodyText value',
    () async {
      // assert
      expect(
        kBodyText,
        GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
        ),
      );
    },
  );

  test(
    'make sure kTextTheme value',
    () async {
      // assert
      expect(kTextTheme.headline5, kHeading5);
      expect(kTextTheme.headline6, kHeading6);
      expect(kTextTheme.subtitle1, kSubtitle);
      expect(kTextTheme.bodyText2, kBodyText);
    },
  );
}
