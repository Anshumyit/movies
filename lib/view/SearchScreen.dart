import 'package:bhojapurimovie/constants/color.dart';
import 'package:bhojapurimovie/viewcontroller/home_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Utility/network.dart';
import '../model/movie_search.dart';

class Searchscreen extends StatefulWidget {
  const Searchscreen({super.key});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  TextEditingController searchDataController = TextEditingController();
  MovieSearchModel? movieSearchModel;
   home_provider? homeProvider;
  // void search(String query) {
  //   homeProvider?.getMovieSearch(query).then((movieSearchData) {
  //     setState(() {
  //       movieSearchData = movieSearchData;
  //     });
  //   });
  // }
  void search(String query) async {
    final result = await Provider.of<home_provider>(context, listen: false).getMovieSearch(query);
    setState(() {
      movieSearchModel = result;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.Blackcolor,
      appBar: AppBar(
        backgroundColor: CustomColors.Blackcolor,
        foregroundColor: CustomColors.Whitecolor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CupertinoSearchTextField(
              controller: searchDataController,
              padding: EdgeInsets.all(10),
              prefixIcon: Icon(CupertinoIcons.search, color: CustomColors.grey),
              suffixIcon: Icon(
                Icons.cancel_outlined,
                color: CustomColors.Whitecolor,
              ),
              style: TextStyle(color: CustomColors.Whitecolor),
              backgroundColor: CustomColors.grey,
              onChanged: (value) {
                if (value.isEmpty) {
                } else {
                  search(searchDataController.text);
                }
              },
            ),
            searchDataController.text.isEmpty
                ? SizedBox()
                : movieSearchModel == null
                ? SizedBox.shrink()
                : ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: movieSearchModel?.results?.length,
                  itemBuilder: (context, index) {
                    final search = movieSearchModel?.results?[index];
                    return search?.backdropPath == null
                        ? SizedBox()
                        : Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  height: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl:
                                            "${movies.imagesUrl}${search?.backdropPath}",
                                        fit: BoxFit.contain,
                                        width: 150,
                                      ),
                                      SizedBox(width: 20),
                                      Flexible(
                                        child: Text(
                                          search?.title ?? "",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(child: Icon(Icons.play_circle_fill_outlined,color: Colors.white,size: 27,))
                          ],
                        );
                  },
                ),
          ],
        ),
      ),
    );
  }
}
