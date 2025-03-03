import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionListScreen extends StatelessWidget {
  const TransactionListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('수입지출내역 현황'),
      ),
      body: ListView.builder(
        itemCount: 10, // TODO: 실제 데이터 개수로 변경
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: ListTile(
              leading: Icon(
                index % 2 == 0 ? Icons.arrow_upward : Icons.arrow_downward,
                color: index % 2 == 0 ? Colors.green : Colors.red,
              ),
              title: Text('항목 ${index + 1}'),
              subtitle: Text('2024-01-${index + 1}'),
              trailing: Text(
                '₩${NumberFormat('#,###').format((index + 1) * 10000)}',
                style: TextStyle(
                  color: index % 2 == 0 ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showTransactionForm(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showTransactionForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const TransactionForm();
      },
    );
  }
}

class TransactionForm extends StatefulWidget {
  const TransactionForm({Key? key}) : super(key: key);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isIncome = true;
  String? _selectedCode;
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  // 임시 코드 리스트 (실제로는 DB나 API에서 가져와야 함)
  final List<String> _incomeCodes = ['급여', '투자수익', '기타수입'];
  final List<String> _expenseCodes = ['식비', '교통비', '주거비'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Text('구분:', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 16),
                ChoiceChip(
                  label: const Text('수입'),
                  selected: _isIncome,
                  onSelected: (selected) {
                    setState(() {
                      _isIncome = selected;
                      _selectedCode = null; // 구분 변경 시 선택된 코드 초기화
                    });
                  },
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('지출'),
                  selected: !_isIncome,
                  onSelected: (selected) {
                    setState(() {
                      _isIncome = !selected;
                      _selectedCode = null; // 구분 변경 시 선택된 코드 초기화
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedCode,
              decoration: const InputDecoration(
                labelText: '코드 선택',
                border: OutlineInputBorder(),
              ),
              items: (_isIncome ? _incomeCodes : _expenseCodes)
                  .map((code) => DropdownMenuItem(
                value: code,
                child: Text(code),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCode = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '코드를 선택해주세요';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: '금액',
                border: OutlineInputBorder(),
                prefixText: '₩ ',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '금액을 입력해주세요';
                }
                if (int.tryParse(value) == null) {
                  return '올바른 금액을 입력해주세요';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _noteController,
              decoration: const InputDecoration(
                labelText: '비고',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('취소'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // TODO: 저장 로직 구현
                      // 데이터 모델 생성 및 저장
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('저장'),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }
}