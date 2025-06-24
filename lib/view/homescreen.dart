import 'package:bhojapurimovie/Utility/network.dart';
import 'package:bhojapurimovie/view/upcomingScreen.dart';
import 'package:bhojapurimovie/view/moviesDetail.dart';
import 'package:bhojapurimovie/viewcontroller/home_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
   var Moviesname =Provider.of<home_provider>(context,listen: false);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Text(
                    'Bhojpuri',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search, size: 27),
                    color: Colors.white,
                  ),
                  Icon(Icons.download, size: 27, color: Colors.white),
                  SizedBox(width: 10),
                  Icon(Icons.cast_sharp, size: 27, color: Colors.white),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  MaterialButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.white38),
                    ),
                    child: Text('Songs', style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(width: 10),
                  MaterialButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.white38),
                    ),
                    child: Text('Movies', style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(width: 10),
                  MaterialButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.white38),
                    ),
                    child: Row(
                      children: [
                        Text('comedy', style: TextStyle(color: Colors.white)),
                        Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: 530,
                      // maxWidth: double.maxFinite,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade800),
                    ),
                   child: FutureBuilder(
                       future: Moviesname.MovieFatchData(),
                       builder: (context,snapshot){
                         if(snapshot.connectionState == ConnectionState.waiting){
                           return Center(child: CircularProgressIndicator(),);
                         } else if(snapshot.hasError){
                           return Center(child: Text('Error : ${snapshot.error}'),);
                         } else if(snapshot.hasData){
                           final Movie=snapshot.data!;
                         return Consumer<home_provider>(
                             builder: (context,value,child){
                           return ClipRRect(
                             borderRadius: BorderRadius.circular(20),
                             child: PageView.builder(
                                 itemCount: Movie.length,
                                 scrollDirection: Axis.horizontal,
                                 itemBuilder: (context,index){
                                   final movieDetail=Movie[index];
                                   return GestureDetector(
                                     onTap: (){
                                       Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieDetailScreen(MovieId: movieDetail.id!,)));
                                     },
                                     child: Container(
                                       constraints: BoxConstraints(
                                         maxHeight: 530,
                                         // maxWidth: double.maxFinite,
                                       ),
                                       decoration: BoxDecoration(
                                           borderRadius: BorderRadius.circular(20),
                                           color: Colors.white,
                                           image: DecorationImage(
                                               fit: BoxFit.cover,
                                               image: CachedNetworkImageProvider("${movies.imagesUrl}${movieDetail.posterPath}"))
        
                                       ),
                                     ),
                                   );
                                 }),
                           );
                         });
        
        
                         }else{
                           return Center(child: Text('PROBLEM TO FEATC DATA',),);
                         }
                       }
        
                   )
                  ),
                  Positioned(
                    bottom: -40,
                      child: Row(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.play_arrow, color: Colors.black,size: 30, ),
                            Text("Play", style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: Colors.white,size: 30, ),
                          Text("My List", style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
        
                  ],))
                ],
              ),
            ),
            SizedBox(height: 50,),
            MovieTypeWidget(future :Provider.of<home_provider>(context,listen: false).UpcomingMoviesFetch() ,movieType: "Upcoming Movies",isReverse: true,),
            SizedBox(height: 12,),
            MovieTypeWidget(future :Provider.of<home_provider>(context,listen: false).TrendingMoviesShow(),movieType: "Trending Movies",),
            SizedBox(height: 12,),
            MovieTypeWidget(future :Provider.of<home_provider>(context,listen: false).TopMovieShowFetch(),movieType: "Top Movies",),
            SizedBox(height: 12,),
            MovieTypeWidget(future :Provider.of<home_provider>(context,listen: false).Tvserieslistsshow(),movieType: " Popular TV Series -Most Watch for you",),
            SizedBox(height: 12,),
            MovieTypeWidget(future :Provider.of<home_provider>(context,listen: false).TopRatingMovieshow(),movieType: " Top Rating Movies",),
            // TrandingMovieWidget(future :Provider.of<home_provider>(context,listen: false).TrendingMovies() ,movieType: "Upcoming Movies",isReverse: true,),
          ],
        ),
      ),
    );
  }

}




