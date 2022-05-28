import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lupin_app/src/model/course_post_model.dart';
import 'package:lupin_app/src/model/post_model.dart';
import 'package:lupin_app/src/model/post_detail_model.dart';
import 'package:lupin_app/src/model/comment_model.dart';
import 'package:lupin_app/src/apis.dart';
import 'package:dio/dio.dart';
import 'package:lupin_app/src/provider/post_provider.dart';
import 'package:lupin_app/src/ui/3/board.dart';
import 'package:provider/provider.dart';
import '../../provider/app_state_provider.dart';

class NoticeRead extends StatefulWidget {
  final Post post;

  const NoticeRead(this.post, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NoticeReadState();
}

class _NoticeReadState extends State<NoticeRead> {
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
      Provider.of<PostProvider>(context, listen: false).getPost(widget.post.id),
      builder: (context, snapshot) {
        if (snapshot.hasData == false) {
          return const Center(
            child: SizedBox(
              child: CircularProgressIndicator(),
              width: 60,
              height: 60,
            ),
          );
        }
        var provider = Provider.of<PostProvider>(context, listen: false);
        DetailPost detailPost = provider.detailPosts!;
        _contentController.text = detailPost.content!;
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text(
              '공지사항',
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
                                child: Text(detailPost.username),
                              ),
                              Container(width: 10,),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  detailPost.createdAt.substring(6,10).replaceAll('-', '/') + ' ' + detailPost.createdAt.substring(11,16),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),),
                              ),
                            ]
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        detailPost.title,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        controller: _contentController,
                        readOnly: true,
                        maxLines: 5,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 0.0),
                            borderRadius: BorderRadius.all(
                              Radius.elliptical(13, 13),
                            ),
                        ),),
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        );
      },
    );
  }

}