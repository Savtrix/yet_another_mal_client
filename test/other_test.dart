
import 'package:yet_another_mal_client/screens/home.dart';
import 'package:flutter_test/flutter_test.dart';


void main() async{
  var token = 'token';
test('api test', () async {
     var data = getImageDataList("one", token);

     expect(data, isNot(null));
  });
}