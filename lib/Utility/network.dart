
import 'package:bhojapurimovie/Utility/contsants.dart';
import 'package:bhojapurimovie/Utility/network.dart';
// var apikey="129288ae14b1dd15268a04560a6cf497";
//  const key ="?api_key=129288ae14b1dd15268a04560a6cf497";

class movies{

  // int? movieID;

  static const baseUrls=appUri.baseUrl;

   static var movieurl= '${baseUrls}/movie/now_playing${appUri.key}';
   static const upcomingmovie='${baseUrls}/movie/upcoming${appUri.key}';
   static const trendingmovies='${baseUrls}/trending/movie/day${appUri.key}';
   static const topmovies='${baseUrls}/movie/top_rated${appUri.key}';
   static const topratingmovies='${baseUrls}/tv/top_rated${appUri.key}';
   static const popularTv='${baseUrls}/tv/popular${appUri.key}';
   // static const movieDetailsScreenapi='${baseUrls}/movie/movieID${appUri.key}';
   static const imagesUrl="https://image.tmdb.org/t/p/original";


  static String movieDetailsScreenApi(int movieID) {
    return '$baseUrls/movie/$movieID${appUri.key}';
  }

}