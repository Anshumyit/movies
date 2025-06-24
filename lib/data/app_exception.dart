

class AppException implements Exception{
  final _message;
  final _prefix;
  AppException([this._message,this._prefix]);

  String toString(){
    return "$_prefix $_message";
  }
}

class FetchDataException extends AppException{
  FetchDataException([String? message]): super(message ,"Error doing communication");
}

class BadRequestException extends AppException{
  BadRequestException([String? message]): super(message ,"Invalid request");
}


class UnauthorisedException extends AppException{
  UnauthorisedException([String? message]): super(message ,"Unathorised request");
}




