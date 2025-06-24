import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../viewcontroller/home_provider.dart'; // Adjust path accordingly
import '../Utility/network.dart'; // For image URL


class MovieTypeWidget extends StatelessWidget {
  final Future future;
  final String movieType;
  final bool isReverse;

  const MovieTypeWidget({
    super.key,
    required this.future,
    required this.movieType,
    this.isReverse = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left:5),
          child: Text(movieType, style: TextStyle(fontSize: 18,color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 180,
          width: double.maxFinite,
          child: FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final movieList = snapshot.data!;
                return Consumer<home_provider>(
                  builder: (context, value, child) {
                    return ListView.builder(
                      itemCount: movieList.length,
                      scrollDirection: Axis.horizontal,
                      reverse: isReverse,
                      itemBuilder: (context, index) {
                        final movieDetail = movieList[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              // Handle tap
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              width: 130,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: CachedNetworkImageProvider(
                                    "${movies.imagesUrl}${movieDetail.posterPath}",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              } else {
                return const Center(child: Text('Problem to fetch data',style: TextStyle(color: Colors.white),));
              }
            },
          ),
        ),
      ],
    );
  }
}
