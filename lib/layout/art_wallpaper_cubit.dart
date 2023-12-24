// import 'dart:developer' as dev;
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:wallpaper/wallpaper.dart';
//
// import '../shared/components/constants.dart';
// part 'art_wallpaper_state.dart';
//
// class ArtWallpaperCubit extends Cubit<ArtWallpaperState> {
//   ArtWallpaperCubit() : super(ArtWallpaperInitial());
//   static ArtWallpaperCubit get(context) => BlocProvider.of(context);
//
//   String home = "Home Screen",
//       lock = "Lock Screen",
//       both = "Both Screen",
//       system = "System";
//
//   Stream<String> progressString;
//   String res;
//   bool downloading = false;
//   var result = "Waiting to set wallpaper";
//   bool isDisable = true;
//
//   int nextImageID = 0;
//
//   Future<void> dowloadImage(BuildContext context) async {
//     progressString = Wallpaper.imageDownloadProgress(
//         images[nextImageID]
//     );
//     progressString.listen((data) {
//         res = data;
//         downloading = true;
//         emit(ArtWallpaperDownlaodImageState());
//       dev.log("DataReceived: " + data);
//     }, onDone: () async {
//         downloading = false;
//         isDisable = false;
//         emit(ArtWallpaperDownlaodImageState());
//
//         dev.log("Task Done");
//     }, onError: (error) {
//         downloading = false;
//         isDisable = true;
//         emit(ArtWallpaperDownlaodImageState());
//         dev.log("Some Error");
//     });
//   }
// void getRandomImage(){
//     nextImageID = Random().nextInt(images.length);
//     isDisable = true;
//     emit(ArtWallpaperDownlaodImageState());
// }
// void refresh(){
//     images =images;
//   emit(ArtWallpaperDownlaodImageState());
//
// }
// }
