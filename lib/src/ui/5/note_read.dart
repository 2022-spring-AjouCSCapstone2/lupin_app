import 'package:chewie_audio/chewie_audio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lupin_app/src/model/note_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class NoteRead extends StatefulWidget {
  final Note note;

  const NoteRead(this.note, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NoteReadState();
}

class _NoteReadState extends State<NoteRead> {
  final _contentController = TextEditingController();
  String url = '';
  Uri? uri;

  void _launchUrl() async {
    if (!await launchUrl(uri!)) throw 'Could not launch $uri';
  }

  void test() async {
    uri = await resolveRedirection(url: widget.note.recordKey!);
  }

  Future<Uri> resolveRedirection({required String url}) async {
    Dio dio = new Dio();
    dio.options.followRedirects = true;
    dio.options.responseType = ResponseType.plain;
    Response response = await dio.get(url.toString());
    return response.realUri;
  }

  VideoPlayerController? videoPlayerController;

  var chewieController;

  var playerWidget;

  @override
  void dispose() {
    videoPlayerController?.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Future.microtask(() async {
      videoPlayerController = VideoPlayerController.network(uri.toString());
      await videoPlayerController!.initialize();
      chewieController = ChewieAudioController(
        videoPlayerController: videoPlayerController!,
        autoPlay: false,
        looping: false,
      );
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.note.type == 'SCRIPT') {
      _contentController.text = widget.note.script!;
    } else if (widget.note.type == 'SUMMARY') {
      _contentController.text = widget.note.summary!;
    } else if (widget.note.type == 'QUESTION') {
      _contentController.text = widget.note.content!;
    } else if (widget.note.type == 'RECORDING') {
      uri = Uri.parse(widget.note.recordKey!);
      // _launchUrl();

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
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                children: <Widget>[
                  SizedBox(height: 40.0),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey)),
                    ),
                    child: Row(children: [
                      Expanded(
                        flex: 2,
                        child: Text(widget.note.type),
                      ),
                      Container(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          widget.note.createdAt
                                  .substring(6, 10)
                                  .replaceAll('-', '/') +
                              ' ' +
                              widget.note.createdAt.substring(11, 16),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(height: 10.0),
                  if (chewieController != null)
                    ChewieAudio(
                      controller: chewieController,
                    ),
                  // TextFormField(
                  //   controller: _contentController,
                  //   readOnly: true,
                  //   maxLines: 20,
                  //   textInputAction: TextInputAction.next,
                  //   decoration: InputDecoration(
                  //     focusedBorder: OutlineInputBorder(
                  //       borderSide: BorderSide(color: Colors.grey, width: 0.0),
                  //       borderRadius: BorderRadius.all(
                  //         Radius.elliptical(13, 13),
                  //       ),
                  //     ),
                  //   ),
                  //   style: TextStyle(
                  //     fontSize: 18,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
