import 'dart:io';
class OAuth2 {

 static final OAuth2 _singleton = OAuth2._internal();

late File credentialsFile;

  factory OAuth2() {
    return _singleton;
  }

  OAuth2._internal()
  {
      credentialsFile = File('~/.myapp/credentials.json');
  }

  signInWithEmailAndPassword({email,password}){

  }
}