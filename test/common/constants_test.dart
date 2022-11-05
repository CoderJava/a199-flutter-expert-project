import 'package:ditonton/common/constants.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

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
