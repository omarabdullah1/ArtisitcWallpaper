import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../models/photos_model.dart';
import '../view/image_view.dart';

Widget wallPaper(List<PhotosModel> listPhotos, BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: StaggeredGrid.count(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: listPhotos.map((PhotosModel? photoModel) {
          return StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 3,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImageView(
                                imgPath: photoModel!.src!.portrait,
                              )));
                },
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                            imageUrl: photoModel!.src!.portrait,
                            placeholder: (context, url) => Container(
                                  color: const Color(0xfff5f8fd),
                                ),
                            fit: BoxFit.cover)),
              ));
        }).toList()),
  );
}
