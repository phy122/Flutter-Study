import 'package:flutter/material.dart';
import 'package:login_app/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();

  bool _isPasswordVisible = false; // 비밀번호 노출 여부
  bool _rememberMe = false; // 자동 로그인
  bool _rememberId = false; // 아이디 저장

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {
                    // TODO: 로그인 처리
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
