
import 'dart:math';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:yet_another_mal_client/main.dart';
import 'package:yet_another_mal_client/models/DetailsResult.dart' as dr;
import 'package:yet_another_mal_client/models/fetchResult.dart' as fr;
import 'package:yet_another_mal_client/screens/details.dart';
import 'package:yet_another_mal_client/screens/home.dart';


void main() {
  group("widgets", () {
  testWidgets('Login page loading', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    expect(find.text('LOGIN'), findsOneWidget);
  });
  testWidgets('Listview to gridview button transform', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp( home: Directionality(textDirection: TextDirection.rtl, child: HomeScreen())));

    expect(find.byIcon(Icons.view_list),findsOneWidget);
    await tester.tap(find.byIcon(Icons.view_list));
    await tester.pump();
    expect(find.byIcon(Icons.grid_on),findsOneWidget);

  });
  testWidgets('Search panel test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp( home: Directionality(textDirection: TextDirection.rtl, child: HomeScreen() )));
    await tester.enterText(find.byType(TextField), 'one');
    await tester.testTextInput.receiveAction(TextInputAction.done);

    expect(find.text('one'), findsWidgets);
  });

  testWidgets('Navigate Home', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.tap(find.text('LOGIN'));
    await tester.pumpAndSettle();
    expect(find.text('Preview'),findsOneWidget);
  });
  testWidgets('Load Details Screen', (WidgetTester tester) async {
    var title = 'aww';
    var from ='2023';
    var to ='2013';
    var synopsis ='some long text';
    var randomImgFromInternet = 'https://upload.wikimedia.org/wikipedia/commons/3/3a/Cat03.jpg';
    dr.DetailsResult details = new dr.DetailsResult(id: 0, title: title, startDate: from, endDate: to, synopsis: synopsis, mainPicture: dr.MainPicture(large: '',medium: randomImgFromInternet) );

    await tester.pumpWidget(MaterialApp( home: Directionality(textDirection: TextDirection.rtl, child: DetailsScreen(details) )));
    await tester.pumpAndSettle();

    expect(find.text(title), findsOneWidget);
    expect(find.text(from), findsOneWidget);
    expect(find.text(to), findsOneWidget);
    expect(find.text(synopsis), findsOneWidget);
  });
  testWidgets('List Generation test', (WidgetTester tester) async {
      fr.Data data = fr.Data(node: fr.Node(id: 1,title: 'aww', mainPicture: fr.MainPicture(medium: '',large: '') ));
      fr.FetchResult res = fr.FetchResult(data:[notSoFastCloner(data),notSoFastCloner(data),notSoFastCloner(data),notSoFastCloner(data)] );

      var home = HomeScreen();
      home.itemList = res.data ?? [];
      await tester.pumpWidget(MaterialApp( home: Directionality(textDirection: TextDirection.rtl, child:home )));
      await tester.tap(find.byIcon(Icons.view_list)); //default  view is grid
      await tester.pumpAndSettle();
      expect(find.text('aww'), findsWidgets);
  });
   testWidgets('Grid Generation test', (WidgetTester tester) async {
      fr.Data data = fr.Data(node: fr.Node(id: 1,title: 'aww', mainPicture: fr.MainPicture(medium: '',large: '') ));
      fr.FetchResult res = fr.FetchResult(data:[notSoFastCloner(data),notSoFastCloner(data),notSoFastCloner(data),notSoFastCloner(data)] );

      var home = HomeScreen();
      home.itemList = res.data ?? [];
      await tester.pumpWidget(MaterialApp( home: Directionality(textDirection: TextDirection.rtl, child:home )));
      await tester.pumpAndSettle();
      expect(find.byType(GridTile), findsWidgets);
  });
  });
}
  fr.Data notSoFastCloner(frData){
    return fr.Data.fromJson(jsonDecode(jsonEncode(frData)));
  }
