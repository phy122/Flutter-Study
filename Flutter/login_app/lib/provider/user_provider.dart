import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:login_app/models/user.dart';

class UserProvider extends ChangeNotifier {
  // 로그인 정보
  late User _userInfo;
  // 로그인 상태
  bool _loginStat = false;

  // getter // get : getter 메소드를 정의하는 키워드
  User get userInfo => _userInfo; //전역변수
  bool get isLogin => _loginStat; // 전역변수

  // setter // set : setter 메소드를 정의하는 키워드
  set userInfo(User userInfo) {
    _userInfo = userInfo;
  }

  set loginStat(bool loginStat) {
    _loginStat = loginStat;
  }

  final Dio _dio = Dio();

  // 로그인 요청
  Future<void> login(String username, String password) async {
    const url = 'http://10.0.2.2:8080/login';
    final requestUrl = '$url?username=$username&password=$password';
    try {
      final response = await _dio.get(requestUrl);

      if (response.statusCode == 200) {
        print('로그인 성공...');
      } else if (response.statusCode == 403) {
        print("아이디 또는 비밀번호가 일치하지 않습니다.");
      } else {
        print("알 수 없는 오류로 로그인헤 실패하였습니다.");
      }
    } catch (e) {
      print("로그인 실패");
    }
  }
}
