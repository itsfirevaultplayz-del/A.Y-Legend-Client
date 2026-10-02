import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ay_legend_client/main.dart';

void main() {
  testWidgets('Home screen shows buttons and opens mod menu', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const AYLegendApp());

    expect(find.text('LAUNCH MINECRAFT'), findsOneWidget);
    expect(find.text('MOD MENU'), findsOneWidget);

    await tester.tap(find.text('MOD MENU'));
    await tester.pumpAndSettle();

    expect(find.text('Custom HUD'), findsOneWidget);
  });
}
