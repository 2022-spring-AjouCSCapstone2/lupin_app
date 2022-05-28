import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lupin_app/src/model/user_model.dart';
import 'package:lupin_app/src/provider/socket_provider.dart';
import 'package:lupin_app/src/provider/user_info_provider.dart';
import 'package:provider/provider.dart';

Future showSimpleDialog2(BuildContext context, String title, String subTitle,
    String name, int questionId,
    {String? buttonText}) async {
  return await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: const EdgeInsets.all(10),
      content: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xffffffff),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 300,
                height: 20,
              ),
              Text(
                '$name $title',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                subTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 15),
              ),
              const SizedBox(
                height: 70,
              ),
              if (Provider.of<UserInfoProvider>(context, listen: false)
                      .currentUser!
                      .userType ==
                  UserType.professor)
                SizedBox(
                  height: 50,
                  width: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Provider.of<SocketProvider>(context, listen: false)
                              .checkQuestion(questionId, true);

                          Navigator.pop(context);
                        },
                        child: Text('좋은 질문이에요'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Provider.of<SocketProvider>(context, listen: false)
                              .checkQuestion(questionId, false);
                        },
                        child: Text('아니에요'),
                      ),
                    ],
                  ),
                ),
              SizedBox(
                height: 50,
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(buttonText ??= '확인'),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
