class User{

  late String uid;
  late String username;
  late String email;
  late String password;
  late String role;

  User({
    required this.username,
    required this.email,
    required this.password,
    required this.uid,
    required this.role,
});

  User.fromJson(Map<String,dynamic> json){
    uid = json['uid'];
    username = json['username'];
    password = json['password'];
    email = json['email'];
    role = json['role'];
  }

  Map<String,dynamic> toMap(){
    return {
      'uid':uid,
      'username':username,
      'email':email,
      'password':password,
      'role':role
    };
  }

}