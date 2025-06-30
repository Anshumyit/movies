import 'dart:convert';
import 'package:bhojapurimovie/Utility/network.dart';
import 'package:bhojapurimovie/data/network/networkAPISERVICE.dart';
import 'package:bhojapurimovie/model/movie_models.dart'
    as movie_models_bhojapuri;
import 'package:bhojapurimovie/model/tranding_movie_model.dart'
    as Trendingmoviesmodel;
import 'package:bhojapurimovie/model/upcoming_movies.dart' as newReleasemovie;
import 'package:bhojapurimovie/model/topmovie_model.dart' as TopmoviesModel;
import 'package:bhojapurimovie/model/popularmodelserial.dart' as TVSERIESLISTS;
import 'package:bhojapurimovie/model/top_rating_models.dart'
    as top_rating_models;
import 'package:bhojapurimovie/model/movies_details_model.dart'
    as moviesdetails_model;
import 'package:bhojapurimovie/model/recommandtionsModel.dart'
as RecommendationModel;

import 'package:flutter/cupertino.dart';

class home_provider with ChangeNotifier {
  List<movie_models_bhojapuri.Results>? movieshow = [];

  // Future<List<Results>?> MovieFatchData() async{
  //  final response= await NetworkApiService().getGetApiResponse(movies.movieurl);
  //  if(response.toString().isNotEmpty){
  //    var res=jsonDecode(response.toString());
  //    var responedata =movie_models_bhojapuri.fromJson(res);
  //    movieshow=responedata.results;
  //    notifyListeners();
  //    return movieshow;
  //  }
  // }
  Future<List<movie_models_bhojapuri.Results>?> MovieFatchData() async {
    try {
      final response = await NetworkApiService().getGetApiResponse(
        movies.movieurl,
      );

      if (response != null && response.toString().isNotEmpty) {
        // final res = jsonDecode(response.toString());
        final responseData = movie_models_bhojapuri.movie_models_bhojapuri
            .fromJson(response);
        movieshow = responseData.results;
        notifyListeners();

        return movieshow;
      } else {
        // Handle empty or null response
        return null;
      }
    } catch (e) {
      print('Error fetching movie data: $e');
      return null;
    }
  }

  //   Upcoming movies show

  List<newReleasemovie.Results>? upcomingMovieShow = [];
  Future<List<newReleasemovie.Results>?> UpcomingMoviesFetch() async {
    try {
      final response = await NetworkApiService().getGetApiResponse(
        movies.upcomingmovie,
      );
      if (response.toString().isNotEmpty) {
        final ressponseData = newReleasemovie.newReleasemovie.fromJson(
          response,
        );
        upcomingMovieShow = ressponseData.results;
        notifyListeners();
        return upcomingMovieShow;
      }
    } catch (e) {
      print('Error fetching movie data: $e');
    }
  }

  // Trending movies show in Bhojapuri

  List<Trendingmoviesmodel.Results>? TrendingMovies = [];
  Future<List<Trendingmoviesmodel.Results>?> TrendingMoviesShow() async {
    try {
      final response = await NetworkApiService().getGetApiResponse(
        movies.trendingmovies,
      );
      if (response.toString().isNotEmpty) {
        final ressponseData = Trendingmoviesmodel.Trendingmoviesmodel.fromJson(
          response,
        );
        TrendingMovies = ressponseData.results;
        notifyListeners();
        return TrendingMovies;
      }
    } catch (e) {
      print('Error fetching movie data: $e');
    }
  }

  // Top movies show in bhojapuri

  List<TopmoviesModel.Results>? TopMoviesshow = [];
  Future<List<TopmoviesModel.Results>?> TopMovieShowFetch() async {
    try {
      final response = await NetworkApiService().getGetApiResponse(
        movies.topmovies,
      );
      if (response.toString().isNotEmpty) {
        final ressponseData = TopmoviesModel.TopmoviesModel.fromJson(response);
        TopMoviesshow = ressponseData.results;
        notifyListeners();
        return TopMoviesshow;
      }
    } catch (e) {
      print('Error fetching movie data: $e');
    }
  }

  // Popular show in Tv seriels

  List<TVSERIESLISTS.Results>? Tvseriels = [];
  Future<List<TVSERIESLISTS.Results>?> Tvserieslistsshow() async {
    try {
      final response = await NetworkApiService().getGetApiResponse(
        movies.popularTv,
      );
      if (response.toString().isNotEmpty) {
        final ressponseData = TVSERIESLISTS.TVSERIESLISTS.fromJson(response);
        Tvseriels = ressponseData.results;
        notifyListeners();
        return Tvseriels;
      }
    } catch (e) {
      print('Error fetching movie data: $e');
    }
  }

  // Top Rating show

  List<top_rating_models.Results>? Top_Rating = [];

  Future<List<top_rating_models.Results>?> TopRatingMovieshow() async {
    try {
      final response = await NetworkApiService().getGetApiResponse(
        movies.topratingmovies,
      );
      if (response.toString().isNotEmpty) {
        final ressponseData = top_rating_models.top_rating_models.fromJson(
          response,
        );
        Top_Rating = ressponseData.results;
        notifyListeners();
        return Top_Rating;
      }
    } catch (e) {
      print('Error fetching movie data: $e');
    }
    return Top_Rating ;
  }

  // movie details screen

  moviesdetails_model.moviesdetails_model? movieDetails;

  Future<moviesdetails_model.moviesdetails_model?> MovieDetailScreenshow(
    int movieId,
  ) async {
    try {
      final response = await NetworkApiService().getGetApiResponse(movies.movieDetailsScreenApi(movieId));
      if (response.toString().isNotEmpty) {
        final ressponseData = moviesdetails_model.moviesdetails_model.fromJson(
          response,
        );
        movieDetails = ressponseData;
        notifyListeners();
        return movieDetails;
      }
    } catch (e) {
      print('Error fetching movie data: $e');
    }
  }


   RecommendationModel.RecommendationModel ? movieRecommandation;

  Future<RecommendationModel.RecommendationModel?> MovieRecommandation(
      int movieId,
      ) async {
    try {
      final response = await NetworkApiService().getGetApiResponse(movies.movieRecommandationApi(movieId));
      if (response.toString().isNotEmpty) {
        final ressponseData = RecommendationModel.RecommendationModel.fromJson(
          response,
        );
        movieRecommandation = ressponseData;
        notifyListeners();
        // return movieRecommandation;
      }
    } catch (e) {
      print('Error fetching movie data: $e');
    }
    return movieRecommandation;
  }


}
