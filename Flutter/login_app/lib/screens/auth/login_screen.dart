import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_app/notifications/snackbar.dart';
import 'package:login_app/provider/user_provider.dart';
import 'package:login_app/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();

  bool _isPasswordVisible = false; // 비밀번호 노출 여부
  bool _rememberMe = false; // 자동 로그
  bool _rememberId = false; // 아이디 저장

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // 안전한 저장소
  final storage = const FlutterSecureStorage();
  String? _username;

  @override
  void initState() {
    super.initState();
    _loadUsername(); // 저장된 아이디 가져오기
  }

  // 저장된 아이디 가져오기 (아이디 저장 했을 때)
  void _loadUsername() async {
    _username = await storage.read(key: 'username');
    if (_username != null) {
      _usernameController.text = _username!;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Provider 선언
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false, // 키패드 overflow
      appBar: AppBar(
        leading: SizedBox.shrink(),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.close))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Image(
                  image: AssetImage('assets/images/Nikelogo.png'),
                  height: 100,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              // 아이디 입력
              TextFormField(
                controller: _usernameController,
                validator: (value) {},
                decoration: const InputDecoration(
                    labelText: '아이디',
                    hintText: '아이디를 입력해주세요',
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 16,
              ),
              // 비밀번호
              TextFormField(
                controller: _passwordController,
                validator: (value) {},
                decoration: InputDecoration(
                    labelText: '비밀번호',
                    hintText: '비밀번호를 입력해주세요',
                    prefixIcon: Icon(Icons.lock_outline_rounded),
                    suffixIcon: IconButton(
                      icon: Icon(_isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    border: OutlineInputBorder()),
                obscureText: _isPasswordVisible,
              ),
              // 자동 로그인 & 아이디 저장
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                      value: _rememberMe,
                      onChanged: (bool? value) {
                        setState(() {
                          _rememberMe = value!;
                        });
                      }),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _rememberMe = !_rememberMe;
                      });
                    },
                    child: Text("자동 로그인"),
                  ),
                  Checkbox(
                      value: _rememberId,
                      onChanged: (bool? value) {
                        setState(() {
                          _rememberId = value!;
                        });
                      }),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _rememberId = !_rememberId;
                      });
                    },
                    child: Text("아이디 저장"),
                  ),
                ],
              ),
              CustomButton(
                  text: "로그인",
                  onPressed: () async {
                    // 유효성 검사
                    if (!_formkey.currentState!.validate()) {
                      return;
                    }

                    final username = _usernameController.text;
                    final password = _passwordController.text;

                    await userProvider.login(username, password,
                        rememberId: _rememberId, rememnerMe: _rememberMe);

                    if (userProvider.isLogin) {
                      print('로그인 성공');

                      Snackbar(
                        text: '로그인에 성공했습니다',
                        icon: Icons.check_circle,
                        backgroundcolor: Colors.green,
                      ).showSnackbar(context);

                      // 메인으로 이동
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/');
                      return;
                    }
                    print('로그인 실패');
                    Snackbar(
                      text: '로그인에 실패했습니다.',
                      icon: Icons.error,
                      backgroundcolor: Colors.red,
                    ).showSnackbar(context);
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(onPressed: () {}, child: Text('아이디 찾기')),
                  TextButton(onPressed: () {}, child: Text('비밀번호 찾기')),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              CustomButton(
                  text: "회원가입",
                  onPressed: () {
                    Navigator.pushNamed(context, "/auth/join");
                  },
                  backgroundColor: Colors.black87)
            ],
          ),
        ),
      ),
    );
  }
}
