class Changefavouritesmodel{
  bool? status;
  String? message;

  Changefavouritesmodel.fromjson(Map<String,dynamic> json){
    status=json['status'];
    message=json['message'];
  }
}