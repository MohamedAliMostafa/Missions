class UserModel
{
 static const String NameModel="Users";
  String id ;
  String name ;
  String  age ;
  String email;

  UserModel({this.id="", required this.name, required this.age, required this.email});
  static UserModel FromJson(Map<String ,dynamic>json)
  {
    UserModel userModel=UserModel(id:json["id"],name: json["name"], age: json["age"], email: json["email"]);
    return userModel;
  }

  Map<String,dynamic>toJson() {
    return {
      "id": id,
      "name": name,
      "age": age,
      "email": age,
    };
  }
}