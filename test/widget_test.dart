import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:album_app/app/app.dart';

void main() {
  testWidgets('AlbumListPage renders correctly', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const MyApp());

    // Check for loading indicator (initial state)
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
