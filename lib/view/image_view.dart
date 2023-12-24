import 'dart:developer';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wallpaper/wallpaper.dart';
import '../shared/components/components.dart';

class ImageView extends StatefulWidget {
 final String? imgPath;

 const ImageView({Key? key, required this.imgPath}) : super(key: key);

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  String? filePath;
  String? res;
  bool downloadingSave = false;
  bool downloading = false;
  bool downloadingBoth = false;
  bool downloadingHome = false;
  bool downloadingLock = false;
  bool downloaded = false;

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child:CachedNetworkImage(
                    imageUrl: widget.imgPath!,
                    placeholder: (context, url) => Container(
                      color: const Color(0xfff5f8fd),
                    ),
                    fit: BoxFit.cover,
                  ),
          ),
          !downloadingSave
              ? Positioned(
                  top: 80.0,
                  right: 10.0,
                  child: InkWell(
                          onTap: () {
                            _save();
                            
                            //Navigator.pop(context);
                          },
                          child: Stack(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width / 8,
                                height: 50,
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xff1C1B1B).withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width / 8,
                                  height: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white24, width: 1),
                                      borderRadius: BorderRadius.circular(40),
                                      gradient: const LinearGradient(
                                          colors: [
                                            Color(0x36FFFFFF),
                                            Color(0x0FFFFFFF)
                                          ],
                                          begin: FractionalOffset.topLeft,
                                          end: FractionalOffset.bottomRight)),
                                  child: const Icon(
                                    Icons.save_alt,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        )
                )
              : Positioned(
                  top: 80.0,
                  right: 10.0,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 8,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xff1C1B1B).withOpacity(0.8),
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width / 8,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white24, width: 1),
                              borderRadius: BorderRadius.circular(40),
                              gradient: const LinearGradient(
                                  colors: [
                                    Color(0x36FFFFFF),
                                    Color(0x0FFFFFFF)
                                  ],
                                  begin: FractionalOffset.topLeft,
                                  end: FractionalOffset.bottomRight)),
                          child: const Icon(
                            Icons.save_alt,
                            color: Colors.grey,
                          )),
                    ],
                  ),
                ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAx isAlignment.end,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    !downloadingBoth
                        ? InkWell(
                            onTap: () async {
                              setState(() {
                                downloadingBoth = true;
                              });
                              _saveSet().then((value) async {
                                // String message = await Wallpaper.bothScreen();
                                // _save().then((value) async {
                                await Wallpaper.bothScreen().then(
                                  (value) async =>
                                      await Wallpaper.bothScreen().then(
                                    (value) => showToast(
                                        text: value,
                                        state: ToastStates.success),
                                  ),
                                );
                              });
                              // Navigator.pop(context);
                            },
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff1C1B1B)
                                        .withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  height: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white24, width: 1),
                                      borderRadius: BorderRadius.circular(40),
                                      gradient: const LinearGradient(
                                          colors: [
                                            Color(0x36FFFFFF),
                                            Color(0x0FFFFFFF)
                                          ],
                                          begin: FractionalOffset.topLeft,
                                          end: FractionalOffset.bottomRight)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const <Widget>[
                                      Text(
                                        "Set Wallpaper",
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 1,
                                      ),
                                      Text(
                                        "Both Home and Lock",
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white70),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const CircularProgressIndicator(),
                    const SizedBox(width: 10.0),
                    !downloadingHome
                        ? InkWell(
                            onTap: () async {
                              setState(() {
                                downloadingHome = true;
                              });
                              _saveSet().then((value) async {
                                // String message = await Wallpaper.homeScreen();
                                // _save().then((value) async {
                                await Wallpaper.homeScreen().then(
                                  (value) async =>
                                      await Wallpaper.homeScreen().then(
                                    (value) => showToast(
                                        text: value,
                                        state: ToastStates.success),
                                  ),
                                );
                                // });
                              });
                              //Navigator.pop(context);
                            },
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width / 8,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff1C1B1B)
                                        .withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 8,
                                    height: 50,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white24, width: 1),
                                        borderRadius: BorderRadius.circular(40),
                                        gradient: const LinearGradient(
                                            colors: [
                                              Color(0x36FFFFFF),
                                              Color(0x0FFFFFFF)
                                            ],
                                            begin: FractionalOffset.topLeft,
                                            end: FractionalOffset.bottomRight)),
                                    child: const Icon(
                                      Icons.home,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          )
                        : const CircularProgressIndicator(),
                    const SizedBox(width: 10.0),
                    !downloadingLock
                        ? InkWell(
                            onTap: () async {
                              setState(() {
                                downloadingLock = true;
                              });
                              _saveSet().then((value) async {
                                // String message = await Wallpaper.lockScreen();
                                // _save().then((value) async {
                                await Wallpaper.lockScreen().then(
                                  (value) async =>
                                      await Wallpaper.lockScreen().then(
                                    (value) => showToast(
                                        text: value,
                                        state: ToastStates.success),
                                  ),
                                );
                                // });
                              });
                              //Navigator.pop(context);
                            },
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width / 8,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff1C1B1B)
                                        .withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 8,
                                    height: 50,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white24, width: 1),
                                        borderRadius: BorderRadius.circular(40),
                                        gradient: const LinearGradient(
                                            colors: [
                                              Color(0x36FFFFFF),
                                              Color(0x0FFFFFFF)
                                            ],
                                            begin: FractionalOffset.topLeft,
                                            end: FractionalOffset.bottomRight)),
                                    child: const Icon(
                                      Icons.lock,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          )
                        : const CircularProgressIndicator(),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                        color: Colors.white60,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _saveSet() async {
    Stream<String> message = Wallpaper.imageDownloadProgress(widget.imgPath!);
    message.listen((data) {
      setState(() {
        res = data;
      });
      if (res != null && res!.isNotEmpty) {
        res = res!.substring(0, res!.length - 1);
      }
      setState(() {
        downloading = true;
        downloadingBoth = true;
        downloadingHome = true;
        downloadingLock = true;
        log("DataReceived: " + data);
      });
    }, onDone: () async {
      setState(() {
        downloading = false;
        downloadingBoth = false;
        downloadingHome = false;
        downloadingLock = false;
        downloaded = true;
        // isDisable = false;
        log("Task Done");
      });
      showToast(
        text: 'Image downloaded successfully $res',
        state: ToastStates.success,
      );
    }, onError: (error) {
      setState(() {
        downloading = false;
        downloadingBoth = false;
        downloadingHome = false;
        downloadingLock = false;
        downloaded = false;
        // isDisable = true;
        log("Some Error");
      });
      showToast(
        text: 'Image downloading error',
        state: ToastStates.error,
      );
    });
  }

  Future<void> _save() async {
    var response = await Dio().get(widget.imgPath!,
        options: Options(responseType: ResponseType.bytes));
    final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    showToast(text: 'Image Saved Successfully', state: ToastStates.success);
    downloadingSave=true;
  }
}
