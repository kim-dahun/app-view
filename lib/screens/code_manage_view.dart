import 'package:flutter/material.dart';

class CodeManagementScreen extends StatefulWidget {
  const CodeManagementScreen({Key? key}) : super(key: key);

  @override
  _CodeManagementScreenState createState() => _CodeManagementScreenState();
}

class _CodeManagementScreenState extends State<CodeManagementScreen> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('수입지출코드 관리'),
      ),
      body: Row(
        children: [
          // 트리 뷰 영역
          Expanded(
            flex: 1,
            child: Card(
              margin: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  // TODO: 실제 트리 데이터로 교체
                  ExpansionTile(
                    title: const Text('수입'),
                    children: [
                      ListTile(
                        title: const Text('급여'),
                        onTap: () {
                          // TODO: 코드 선택 처리
                        },
                      ),
                      ListTile(
                        title: const Text('투자수익'),
                        onTap: () {
                          // TODO: 코드 선택 처리
                        },
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: const Text('지출'),
                    children: [
                      ListTile(
                        title: const Text('식비'),
                        onTap: () {
                          // TODO: 코드 선택 처리
                        },
                      ),
                      ListTile(
                        title: const Text('교통비'),
                        onTap: () {
                          // TODO: 코드 선택 처리
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // 코드 등록 폼 영역
          Expanded(
            flex: 2,
            child: Card(
              margin: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '하위 코드 등록',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _codeController,
                        decoration: const InputDecoration(
                          labelText: '코드',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '코드를 입력해주세요';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          labelText: '설명',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '설명을 입력해주세요';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // TODO: 코드 저장 처리
                              }
                            },
                            child: const Text('저장'),
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            onPressed: () {
                              _codeController.clear();
                              _descriptionController.clear();
                            },
                            child: const Text('취소'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}