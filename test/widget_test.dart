import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_personal_website/main.dart';
import 'package:visibility_detector/visibility_detector.dart';

void main() {
  testWidgets('portfolio app renders initial shell',
      (WidgetTester tester) async {
    VisibilityDetectorController.instance.updateInterval = Duration.zero;

    await tester.pumpWidget(const PortfolioApp());
    await tester.pump(const Duration(milliseconds: 900));

    expect(find.text('AKSHAY'), findsWidgets);
    expect(find.text('Download Resume'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });
}
