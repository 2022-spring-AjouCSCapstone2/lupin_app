import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lupin_app/src/model/quiz_model.dart';
import 'package:lupin_app/src/provider/socket_provider.dart';
import 'package:provider/provider.dart';

Future showSimpleDialog(BuildContext context, String title, String subTitle,
    List<QuizModel> content, int quizId,
    {String? buttonText}) async {
  var groupValue;
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
                title,
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
              StatefulBuilder(builder: (context, setState) {
                return Column(
                    children: List.generate(content.length, (index) {
                  return Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text(content[index].content),
                          onTap: () {},
                        ),
                      ),
                      Radio<int>(
                        value: index,
                        groupValue: groupValue,
                        onChanged: (value) {
                          setState(() {
                            groupValue = value;
                          });
                        },
                      ),
                    ],
                  );
                }));
              }),
              // Text(
              //   content,
              //   textAlign: TextAlign.center,
              //   style: Theme.of(context).textTheme.bodyText1,
              // ),
              const SizedBox(
                height: 70,
              ),
              SizedBox(
                height: 50,
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    var provider =
                        Provider.of<SocketProvider>(context, listen: false);
                    provider.answer(quizId, groupValue);
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
