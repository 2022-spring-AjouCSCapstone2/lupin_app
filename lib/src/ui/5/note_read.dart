import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lupin_app/src/model/course_post_model.dart';
import 'package:lupin_app/src/model/post_model.dart';
import 'package:lupin_app/src/model/post_detail_model.dart';
import 'package:lupin_app/src/model/note_model.dart';
import 'package:lupin_app/src/model/comment_model.dart';
import 'package:lupin_app/src/apis.dart';
import 'package:dio/dio.dart';
import 'package:lupin_app/src/provider/post_provider.dart';
import 'package:lupin_app/src/ui/3/board.dart';
import 'package:provider/provider.dart';
import '../../provider/app_state_provider.dart';

class NoteRead extends StatefulWidget {
  final Note note;

  const NoteRead(this.note, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NoteReadState();
}

class _NoteReadState extends State<NoteRead> {
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if(widget.note.type == 'SCRIPT'){
      _contentController.text = widget.note.script!;
    } else if(widget.note.type == 'QUESTION'){
      _contentController.text = widget.note.content;
    }
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text(
              '강의노트',
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  child:
                  ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    children: <Widget>[
                      SizedBox(height: 40.0),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey)),
                        ),
                        child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(widget.note.type),
                              ),
                              Container(width: 10,),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  widget.note.createdAt.substring(6,10).replaceAll('-', '/') + ' ' + widget.note.createdAt.substring(11,16),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),),
                              ),
                            ]
                        ),
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        controller: _contentController,
                        readOnly: true,
                        maxLines: 20,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 0.0),
                            borderRadius: BorderRadius.all(
                              Radius.elliptical(13, 13),
                            ),
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
  }
}