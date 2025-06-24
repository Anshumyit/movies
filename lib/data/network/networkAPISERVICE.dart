
import 'dart:convert';
import 'dart:io';
import 'package:bhojapurimovie/data/app_exception.dart';
import 'package:bhojapurimovie/data/network/BaseApiservice.dart';
import 'package:http/http.dart' as http;


class NetworkApiService extends BaseApiServices{


  @override
  Future getGetApiResponse(String url) async{
    dynamic responseJson;

    try{
      final response= await http.get(Uri.parse(url));
      // final response = await http.get(url);
      responseJson=returnRespose(response);
    }on SocketException{
      throw  FetchDataException('No Internet Connection');
    }

    return responseJson;
  }


  @override

  Future getPostApiResponse(String url, dynamic data) async{
    dynamic reponseJson;
    try{

      final response= await http.post(
          Uri.parse(url),
          body:data
      );
      reponseJson =returnRespose(response);

    }on SocketException{
      throw FetchDataException('No Internet Connection');
    }

    return reponseJson;
  }




  dynamic returnRespose(http.Response response){

    switch(response.statusCode){
      case 200:
        dynamic responseJson=jsonDecode(response.body);
        return responseJson;

      case 400:
        throw BadRequestException(response.body.toString());
      case 500:
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException('Error occured while communicating with server'+
            'with status code'+ response.statusCode.toString());
    }
  }


}