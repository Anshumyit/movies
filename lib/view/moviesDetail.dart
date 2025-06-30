import 'package:bhojapurimovie/constants/vertical_horizantal_space.dart';
import 'package:bhojapurimovie/model/movies_details_model.dart';
import 'package:bhojapurimovie/view/upcomingScreen.dart';
import 'package:bhojapurimovie/viewcontroller/home_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/color.dart';
import '../constants/fonstSize.dart';
import '../Utility/network.dart';
import '../constants/stylesfonts.dart';

class MovieDetailScreen extends StatefulWidget {
  final int MovieId;
  const MovieDetailScreen({super.key, required this.MovieId});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late Future<moviesdetails_model?> movieFuture;



  String formathours(int runtime) {
    int hours = runtime ~/ 60;
    int minutes = runtime ~/ 60;
    return '${hours}h ${minutes}m';
  }

  @override
  void initState() {
    super.initState();
    // Provider.of<home_provider>(context,listen: false).MovieDetailScreenshow(widget.MovieId).then((value) {
    //   provider= value ?? moviesdetails_model();
    // },);
    movieFuture = Provider.of<home_provider>(
      context,
      listen: false,
    ).MovieDetailScreenshow(widget.MovieId);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: movieFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error : ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final movie = snapshot.data!;
            String generesText=movie.genres?.map((value)=>value.name ).join(',') ?? "";
            return Consumer<home_provider>(
              builder: (context, value, child) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: size.height * 0.5,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                  "${movies.imagesUrl}${movie.posterPath}",
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 15,
                            top: 50,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.black54,
                                    child: Icon(Icons.close, color: Colors.white),
                                  ),
                                ),
                                UtilityWidget.horizontalsSpace(5),
                                CircleAvatar(
                                  backgroundColor: Colors.black54,
                                  child: Icon(Icons.cast, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 100,
                            bottom: 100,
                            left: 150,
                            // top: MediaQuery.of(context).size.height * 0.2,
                            // bottom: MediaQuery.of(context).size.height * 0.2,
                            // left: MediaQuery.of(context).size.width * 0.5,
                            child: Icon(
                              Icons.play_circle_outline,
                              color: Colors.white,size: 70,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 25, left: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  movie.title ?? "",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Spacer(),
                                Icon(Icons.movie, color: Colors.white),
                              ],
                            ),
                  
                            Row(
                              children: [
                                Text(
                                  movie.releaseDate.toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                                UtilityWidget.horizontalsSpace(5),
                                Text(
                                  formathours(movie.runtime ?? 0),
                                  style: TextStyle(color: Colors.white),
                                ),
                                UtilityWidget.horizontalsSpace(5),
                                Text("HD", style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.play_arrow,
                                size: 38,
                                color: Colors.black,
                              ),
                              Text(
                                'Play',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      UtilityWidget.verticalSpace(15),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade700,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.download,
                                size: 38,
                                color: Colors.black,
                              ),
                              Text(
                                'Download',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      UtilityWidget.verticalSpace(15),
                      Text(generesText,style: TextStyle(fontSize: 17,color: Colors.white),),
                      UtilityWidget.verticalSpace(15),
                      Text(movie.overview ?? "",maxLines:5,overflow:TextOverflow.ellipsis,style: TextStyle(color: Colors.white,fontSize: 16),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Icon(Icons.add,color: Colors.white,),
                              Text('My List',style: CustomTextStyle.customStyle(Constants.fontFamily, CustomColors.Whitecolor, Constants.font10Size, Constants.fontWeight),)
                            ],
                          ),

                          UtilityWidget.horizontalsSpace(12),
                          Column(
                            children: [
                              Icon(Icons.star_rate_outlined,color: Colors.white,),
                              Text('Rate',style: CustomTextStyle.customStyle(Constants.fontFamily, CustomColors.Whitecolor, Constants.font10Size, Constants.fontWeight),)
                            ],
                          ),
                          UtilityWidget.horizontalsSpace(12),
                          Column(
                            children: [
                              Icon(Icons.share,color: Colors.white,),
                              Text('share',style: CustomTextStyle.customStyle(Constants.fontFamily, CustomColors.Whitecolor, Constants.font10Size, Constants.fontWeight),)
                            ],
                          )
                        ],
                      ),
                      UtilityWidget.verticalSpace(20),
                      MovieTypeWidget(
                        future: Provider.of<home_provider>(context, listen: false).MovieRecommandation(widget.MovieId),
                        movieType: "More like this",
                        isReverse: true,
                      )

                      // FutureBuilder(future: Provider.of<home_provider>(context,listen: false).MovieRecommandation(widget.MovieId), builder: (context,snapshot){
                      //   if(snapshot.connectionState==ConnectionState.waiting){
                      //     return Center(child: CircularProgressIndicator(),);
                      //   } else if(snapshot.hasError){
                      //     return Center(child: Text('Error: ${snapshot.error}'));
                      //   } else if (snapshot.hasData){
                      //     final movieList = snapshot.data!;
                      //       return movieList.results!.isEmpty? SizedBox(): Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Text('More like this',style: TextStyle(color: Colors.white),),
                      //           UtilityWidget.verticalSpace(20),
                      //           SizedBox(
                      //             height:200,
                      //             child: ListView.builder(
                      //               shrinkWrap: true,
                      //               scrollDirection: Axis.horizontal,
                      //               itemCount: movieList.results?.length,
                      //                 itemBuilder: (context,index){
                      //                 return CachedNetworkImage(imageUrl: "${movies.imagesUrl}${movieList.results?[index].posterPath}",height: 200,width: 150,fit: BoxFit.cover,);
                      //                 })
                      //           )
                      //         ],
                      //       );
                      //
                      //   } else{
                      //     return const Center(child: Text('Problem to fetch data',style: TextStyle(color: Colors.white),));
                      //   }
                      // })

                    ],
                  ),
                );
              },
            );
          }

          return const Center(child: Text('No data found'));
        },
      ),
    );
  }
}
