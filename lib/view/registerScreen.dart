import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_maintenance/components/functions.dart';
import 'package:work_maintenance/view/loginScreen.dart';

class registerScreen extends StatefulWidget {
  @override
  _registerScreenState createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var formkey = GlobalKey<FormState>();
  bool password_show = true;
  String role = 'user';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Register",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: usernameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: 'User Name',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder()),
                    validator: (value) {
                      if (value!.isEmpty) return "User Name mustn't be empty";
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: 'Email Address',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder()),
                    validator: (value) {
                      if (value!.isEmpty)
                        return "Email Address mustn\'t be empty";
                      if (!GetUtils.isEmail(value))
                        return "please enter a valid email";
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              password_show = !password_show;
                            });
                          },
                          icon: Icon(password_show
                              ? Icons.remove_red_eye
                              : Icons.visibility_off),
                        ),
                        border: OutlineInputBorder()),
                    validator: (value) {
                      if (value!.isEmpty) return "password mustn\'t be empty";
                      if (value.length < 6)
                        return "Password should be at least 6 characters";
                      return null;
                    },
                    obscureText: password_show,
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(width: 25,),
                      buildRoleItem('admin', Colors.red),
                      SizedBox(width: 20,),
                      buildRoleItem('user', Colors.blue),
                      SizedBox(width: 25,),
                    ],
                  ),
                  SizedBox(height: 30),
                  Container(
                    child: ElevatedButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            )
                                .then((value) {
                              createUser(
                                  uid: value.user!.uid,
                                  username: usernameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  role: role,
                                  context: context);
                              Get.off(loginScreen());
                            }).catchError((error) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  "The Email Address is already in use",
                                  softWrap: true,
                                  style: TextStyle(fontSize: 20),
                                ),
                                backgroundColor: Colors.redAccent,
                                duration: Duration(seconds: 2),
                              ));
                            });
                          }
                        },
                        child:
                            Text("Register", style: TextStyle(fontSize: 20))),
                    width: double.infinity,
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Expanded buildRoleItem(String type,Color color) {
    return Expanded(
      child: InkWell(
        onTap: (){
          setState(() {
            role = type;
          });
        },
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Icon(Icons.person),
                SizedBox(height: 10,),
                Text(type,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)
              ],
            ),
          ),
          height: 74,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: color,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: role==type ? 0.0 : 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
