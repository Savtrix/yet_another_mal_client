
import 'package:yet_another_mal_client/screens/home.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:math';

void main() async{
  var token = 'token';
  group('tests', () {
    test('api list test', () async {
     var data = getImageDataList("one", token);
     expect(data, isNot(null));
    });
    test('api details test', () async {
      var data = getDetails(123, token);
      expect(data, isNot(null));
    });
    test('title cutter', () {
      var t = CutTitle('dadaadadadadadadadadadadadadaeqtfweuqfeqy8iefwtgey78oqtdqyudgqoidygq');
      expect(t.length, 25 );
    });

    test('Luck Test', () async {
      expect(Random().nextInt(1000), 777);
    });

  });
}