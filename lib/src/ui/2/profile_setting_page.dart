
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lupin_app/src/ui/1/profile_page.dart';

class ProfileSettingPage extends StatefulWidget {
  const ProfileSettingPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfileSettingPageState();
}

class _ProfileSettingPageState extends State<ProfileSettingPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Form(
            key: formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              children: <Widget>[
                const SizedBox(height: 40),
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfilePage(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.arrow_back_ios),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "회원가입",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                            filled: true,
                            labelText: '이름 *'
                        ),
                        validator: (value) => CheckValidate().validateName(value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    Container(width: 10,),
                    Expanded(
                      flex: 1,
                      child: DropdownButtonFormField2(
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.only(left: 10),
                          filled: true,
                          labelText: '사용자 유형 *',
                        ),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black45,
                        ),
                        iconSize: 30,
                        buttonHeight: 60,
                        buttonPadding: const EdgeInsets.only(right: 10),
                        items: _userType.map((value) {
                          return DropdownMenuItem(
                            child: Container(
                                child: Text(value)
                            ),
                            value: value,);
                        }).toList(),
                        validator: (value) => CheckValidate().validateType(value.toString()),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (String? value){
                          setState(() {
                            _selectedValue = value!;
                          });
                        },
                        onSaved: (value) {
                          _selectedValue = value.toString();
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.0),
                TextFormField(
                  controller: _mailController,
                  decoration: InputDecoration(filled: true, labelText: '이메일 *'),
                  validator: (value) => CheckValidate().validateEmail(value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 12.0),
                TextFormField(
                  controller: _pwController,
                  decoration: InputDecoration(
                    filled: true,
                    labelText: '비밀번호 *',
                    hintText: '특수문자, 대소문자, 숫자 포함 8 ~ 15자',
                  ),
                  validator: (value) => CheckValidate().validatePassword(value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: true,
                ),
                SizedBox(height: 12.0),
                TextFormField(
                  controller: _pw2Controller,
                  decoration: InputDecoration(
                      filled: true,
                      labelText: '비밀번호 확인 *'
                  ),
                  validator: (value) => CheckValidate().validatePassword2(_pwController.text, value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: true,
                ),
                SizedBox(height: 12.0),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                      filled: true,
                      labelText: '전화번호'
                  ),
                  validator: (value) => CheckValidate().validatePhone(value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 12.0),
                TextFormField(
                  controller: _sIdController,
                  decoration: InputDecoration(
                      filled: true,
                      labelText: '학번/교번 *'
                  ),
                  validator: (value) => CheckValidate().validateSId(value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 12.0),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: CheckboxListTile(
                          title: Text('개인정보 수집 및 이용 동의',style: TextStyle(color: Colors.grey)),
                          value: _isChecked,
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (bool? value) {
                            if(value != null){
                              setState(() {
                                _isChecked = value;
                              });
                            }
                          }),
                    ),
                    Container(width: 10,),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {
                          //약관 보여주기
                        },
                        icon: const Icon(Icons.chevron_right_outlined), color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                ElevatedButton(
                  onPressed: buttonEnable() ? () => buttonFunction() : null,
                  child: Text("회원가입"),
                ),
              ],
            ),
          ),
        )
    );
  }

}