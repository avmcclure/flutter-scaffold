import 'package:flutter_scaffold/content.dart';
import 'package:flutter_scaffold/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('content is valid', () {
    expect(items, isNotEmpty);
    expect(items.map((i) => i.name).toSet().length, items.length,
        reason: 'item names must be unique');
    for (final q in quiz) {
      expect(q.answerIndex, inInclusiveRange(0, q.options.length - 1),
          reason: q.question);
    }
  });

  testWidgets('app opens an item', (tester) async {
    await tester.pumpWidget(const App());
    expect(find.text(appTitle), findsOneWidget);
    await tester.tap(find.text(items.first.name));
    await tester.pumpAndSettle();
    expect(find.text(items.first.description), findsOneWidget);
  });
}
