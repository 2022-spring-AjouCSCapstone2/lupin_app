import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _mailController = TextEditingController();
  final _pwController = TextEditingController();
  final _departController = TextEditingController();
  final _sIdController = TextEditingController();
  bool? _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 50),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(filled: true, labelText: '이름'),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _mailController,
              decoration: const InputDecoration(filled: true, labelText: '이메일'),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _pwController,
              decoration:
                  const InputDecoration(filled: true, labelText: '비밀번호'),
              obscureText: true,
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _departController,
              decoration: const InputDecoration(filled: true, labelText: '학과'),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _sIdController,
              decoration: const InputDecoration(filled: true, labelText: '학번'),
            ),
            CheckboxListTile(
                title: const Text('개인정보 수집에 동의합니다.'),
                value: _isChecked,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (bool? value) {
                  if (value != null) {
                    print(value);
                    setState(() {
                      _isChecked = value;
                    });
                  }
                }),
            const SizedBox(height: 50.0),
            ElevatedButton(
              onPressed: () {},
              child: const Text("회원가입"),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text("비밀번호를 잊으셨나요?"),
            )
          ],
        ),
      ),
    );
  }
}
