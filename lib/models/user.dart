

class User{

  int? id;
  String? email;
   String? passMd5;

    User({this.email, this.passMd5, this.id});
    
   User.fromJson(Map<String, dynamic> json){
     this.email = json['email'];
     this.passMd5 = json['passMd5'];
     this.id = json['id'];
   }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> json = {};
    json['email'] = email;
    json['passMd5'] = email;
    json['id'] = id;
    return json;
  }

}