class UserModel {
  String? email;
  String? password;
  UserModel({this.email, this.password});
  factory UserModel.fromMap(map){
    return UserModel(
        email:map['email'],
        password:map['password']
    );

  }
  Map<String,dynamic> toMap() => {'email':email,'password':password};

}