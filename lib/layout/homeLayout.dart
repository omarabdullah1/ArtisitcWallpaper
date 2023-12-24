// import 'dart:developer' as dev;
// import 'package:artisticwallpaper/layout/art_wallpaper_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:wallpaper/wallpaper.dart';
//
// import '../shared/components/constants.dart';
//
// class HomeLayout extends StatelessWidget {
//   const HomeLayout({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var cubit = ArtWallpaperCubit.get(context);
//     return BlocConsumer<ArtWallpaperCubit, ArtWallpaperState>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         return Scaffold(
//           body: SafeArea(
//             child: Container(
//                 margin: const EdgeInsets.only(top: 20),
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height,
//                 child: RefreshIndicator(
//                   onRefresh: () => Future.delayed(
//                     const Duration(seconds: 2),
//                     () => cubit.refresh(),
//                   ),
//                   child: SingleChildScrollView(
//                     child: StaggeredGrid.count(
//                       crossAxisCount: 4,
//                       mainAxisSpacing: 4,
//                       crossAxisSpacing: 4,
//                       children: images
//                           .map((e) => StaggeredGridTile.count(
//                               crossAxisCellCount: 2,
//                               mainAxisCellCount: 2,
//                               child: Image(image: NetworkImage(e),)))
//                           .toList(),
//                     ),
//                   ),
//                 )),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget imageDownloadDialog(context) {
//     return SizedBox(
//       height: 120.0,
//       width: 200.0,
//       child: Card(
//         color: Colors.black,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const CircularProgressIndicator(),
//             const SizedBox(height: 20.0),
//             Text(
//               "Downloading File : ${ArtWallpaperCubit.get(context).res}",
//               style: const TextStyle(color: Colors.white),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
