import 'package:artisticwallpaper/view/categorie_screen.dart';
import 'package:artisticwallpaper/view/search_view.dart';
import 'package:artisticwallpaper/widget/widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'data/data.dart';
import 'models/categorie_model.dart';
import 'models/photos_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategorieModel> categories = [];
  int noOfImageToLoad = 30;
  List<PhotosModel> photos = [];
  BannerAd? _bannerAd;

  getTrendingWallpaper() async {
    // photos.clear();
    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/curated?per_page=$noOfImageToLoad&page=1"),
        headers: {"Authorization": apiKEY}).then((value) {
      //print(value.body);

      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        //print(element);
        PhotosModel photosModel = PhotosModel();
        photosModel = PhotosModel.fromMap(element);
        photos.add(photosModel);
        //print(photosModel.toString()+ "  "+ photosModel.src.portrait);
      });
      // photos.forEach((element) {
      //   print(element.alt);
      //   print(element.src.portrait);
      //   print(element.src.landscape);
      //   print(element.src.large);
      //   print(element.src.medium);
      // });
      setState(() {});
    });
  }

  TextEditingController searchController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    //getWallpaper();
    getTrendingWallpaper();
    categories = getCategories();
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        noOfImageToLoad = noOfImageToLoad + 30;
        getTrendingWallpaper();
      }
    });
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: BannerAd.testAdUnitId,
    );
    _bannerAd!.load();
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd!.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text('Artistic Wallpaper',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontFamily: 'Pacifico', color: Colors.white))),
        elevation: 0.0,
        backgroundColor: Colors.teal,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(const Duration(seconds: 2), () {
              getTrendingWallpaper();
              categories = getCategories();
              super.initState();

              _scrollController.addListener(() {
                if (_scrollController.position.pixels ==
                    _scrollController.position.maxScrollExtent) {
                  noOfImageToLoad = noOfImageToLoad + 30;
                  getTrendingWallpaper();
                }
              });
            });
          },

          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xfff5f8fd),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextField(
                          controller: searchController,
                          decoration: const InputDecoration(
                              hintText: "Search Wallpapers",
                              border: InputBorder.none),
                        ),
                      )),
                      InkWell(
                          onTap: () {
                            if (searchController.text != "") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchView(
                                            search: searchController.text,
                                          )));
                            }
                          },
                          child: const Icon(Icons.search))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      itemCount: categories.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return CategoriesTile(
                          imgUrls: categories[index].imgUrl,
                          categorie: categories[index].categorieName,
                        );
                      }),
                ),
                wallPaper(photos, context),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text(
                      "Photos provided By ",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                          fontFamily: 'Jannah'),
                    ),
                    Text(
                      "Pexels",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                          fontFamily: 'Jannah'),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Some images Could have content supported by LGBTQ+",
                  style: TextStyle(
                      color: Colors.red, fontSize: 12, fontFamily: 'Jannah'),
                ),
                const Text(
                  "app makers don't support that.",
                  style: TextStyle(
                      color: Colors.red, fontSize: 12, fontFamily: 'Jannah'),
                ),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  final String? imgUrls, categorie;

  const CategoriesTile(
      {Key? key, required this.imgUrls, required this.categorie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategorieScreen(
              categorie: categorie,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        child: kIsWeb
            ? Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: kIsWeb
                        ? Image.network(
                            imgUrls!,
                            height: 50,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        : CachedNetworkImage(
                            imageUrl: imgUrls!,
                            height: 50,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Container(
                      width: 100,
                      alignment: Alignment.center,
                      child: Text(
                        categorie!,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Jannah',
                        ),
                      )),
                ],
              )
            : Stack(
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: kIsWeb
                          ? Image.network(
                              imgUrls!,
                              height: 50,
                              width: 100,
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              imageUrl: imgUrls!,
                              height: 50,
                              width: 100,
                              fit: BoxFit.cover,
                            )),
                  Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 100,
                    alignment: Alignment.center,
                    child: Text(
                      categorie!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Jannah'),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
