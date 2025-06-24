import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scorely/uiLayer/screens/splash_screen.dart';

void main() {
  testWidgets('Shows splash screen initially', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // Initial frame (splash screen)
    expect(find.byType(SplashView), findsOneWidget);

    // Wait 3 seconds + 1 frame to show HomeLoader
    await tester.pump(const Duration(seconds: 3));
    await tester.pump();

    // SplashView should disappear
    expect(find.byType(SplashView), findsNothing);
  });
}
