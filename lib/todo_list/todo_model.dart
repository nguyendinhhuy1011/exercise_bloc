import 'dart:convert';

class TodoModel{
  String? name;
  String? id;
  String? dateTime;

  TodoModel({this.name, this.id, this.dateTime});
  Map<String, dynamic> convertModelToJson(){
    Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['id'] =id;
    data['dateTime'] = dateTime;
    return data;
  }


  String convertJsonToString() {
    return jsonEncode(convertModelToJson());
  }

  TodoModel.fromStringLocal(String data){
    Map<String, dynamic> dataJson = jsonDecode(data);
    name = dataJson['name'];
    id = dataJson['id'];
    dateTime = dataJson['dateTime'];
  }
}