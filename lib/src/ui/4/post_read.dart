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

class PostRead extends StatefulWidget {
  final Post post;

  const PostRead(this.post, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PostReadState();
}

class _PostReadState extends State<PostRead> {
  final _contentController = TextEditingController();
  final _commentController = TextEditingController();

  void postComment() async{
    try{
      Response response = await Apis.instance.postComment(
          content: _commentController.text,
          postId: widget.post.id
      );
      setState(() {});
      _commentController.text = '';
    } catch (e){
      print(e);
    }
  }


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
              '게시판',
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
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 20.0),
                Container(
                  child: buildCourseListView(detailPost.comments),
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey)),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.elliptical(13, 13),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: TextFormField(
                          controller: _commentController,
                          decoration: InputDecoration(
                            hintText: '댓글을 입력하세요.',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: () { postComment(); },
                          icon: Icon(
                            Icons.send_rounded,
                            color: Color(0xFF5db075),
                          ),
                        ),
                      ),
                    ],
                  )
                )
              ],
            ),
          ),
        );
      },
    );
  }

  ListView buildCourseListView(List<Comment>? comments) {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Card(
                child: ListTile(
                  title: Row(
                    children: [
                      Text(
                        comments![index].content,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),

                ),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) {

          return Container();
        },
        itemCount: comments!.length);
  }
}