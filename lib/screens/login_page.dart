import 'package:flutter/material.dart';
import '../services/api_client.dart';
import '../models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, this.comCd, this.userId}) : super(key: key);

  final String? comCd;
  final String? userId;

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _companyCodeController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false; // 로딩 상태 추가
  final ApiClient _apiClient = ApiClient(); // API 클라이언트 인스턴스

  @override
  void initState() {
    super.initState();
    if (widget.comCd != null) {
      _companyCodeController.text = widget.comCd!;
    }
    if (widget.userId != null) {
      _userIdController.text = widget.userId!;
    }
  }

  @override
  void dispose() {
    _companyCodeController.dispose();
    _userIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // 로그인 처리 함수 - API 연동 추가
  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final request = LoginRequest(
        comCd: _companyCodeController.text,
        userId: _userIdController.text,
        password: _passwordController.text,
      );

      final response = await _apiClient.service.login(request);

      if (response.success) {
        // 로그인 성공 시 토큰 저장
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response.token);
        await prefs.setString('refreshToken', response.refreshToken);
        await prefs.setString('userId', response.userInfo.userId);
        await prefs.setString('comCd', response.userInfo.comCd);

        if (mounted) {
          // 메인 화면으로 이동
          Navigator.pushReplacementNamed(
            context,
            '/main',
            arguments: {
              'comCd': response.userInfo.comCd,
              'userId': response.userInfo.userId,
            },
          );
        }
      } else {
        if (mounted) {
          // 로그인 실패 시 에러 메시지 표시
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.message ?? '로그인에 실패했습니다.')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        // 오류 발생 시 에러 메시지 표시
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('로그인 중 오류가 발생했습니다: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // 회원가입 화면으로 이동
  void _goToSignUp() {
    Navigator.pushNamed(context, '/signup');
  }

  // 계정 찾기 화면으로 이동
  void _goToFindAccount() {
    Navigator.pushNamed(context, '/find-account');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('로그인'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 회사 로고 (원하는 경우 추가)
              const SizedBox(height: 50),
              Image.asset(
                'assets/images/logo.png',
                height: 100,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    height: 100,
                    child: Center(child: Text('회사 로고')),
                  );
                },
              ),
              const SizedBox(height: 50),

              // 회사코드 입력 필드
              TextFormField(
                controller: _companyCodeController,
                decoration: const InputDecoration(
                  labelText: '회사코드',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.business),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '회사코드를 입력해주세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 아이디 입력 필드
              TextFormField(
                controller: _userIdController,
                decoration: const InputDecoration(
                  labelText: '아이디',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '아이디를 입력해주세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 비밀번호 입력 필드
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: '비밀번호',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '비밀번호를 입력해주세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),

              // 로그인 버튼
              ElevatedButton(
                onPressed: _isLoading ? null : _handleLogin,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('로그인', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 16),

              // 회원가입 및 계정 찾기 버튼 (가로 배치)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: _goToSignUp,
                    child: const Text('회원가입'),
                  ),
                  const SizedBox(width: 16),
                  const Text('|'),
                  const SizedBox(width: 16),
                  TextButton(
                    onPressed: _goToFindAccount,
                    child: const Text('계정 찾기'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}