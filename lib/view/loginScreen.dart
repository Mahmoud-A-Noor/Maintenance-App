import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_maintenance/components/functions.dart';
import 'package:work_maintenance/model/preferences.dart';
import 'package:work_maintenance/view/registerScreen.dart';
import 'package:work_maintenance/view/taskScreen.dart';

class loginScreen extends StatefulWidget {

  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  bool password_show = true;

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: 'Email Address',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder()),
                    validator: (value){
                      if(value!.isEmpty)
                        return "Email Address mustn\'t be empty";
                      if(!GetUtils.isEmail(value))
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
                              setState((){
                                password_show=!password_show;
                              });
                          }, icon: Icon(password_show?Icons.remove_red_eye:Icons.visibility_off),),
                          border: OutlineInputBorder()),
                    validator: (value){
                      if(value!.isEmpty)
                        return "password mustn't be empty";
                      if(value.length<6)
                        return "Password should be at least 6 characters";
                      return null;
                    },
                    obscureText: password_show,
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: ElevatedButton(
                        onPressed: () {
                          if(formkey.currentState!.validate())
                            {
                              FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text
                              ).then((value) async{
                                String role = await getRole(value.user!.uid);
                                await UserPreferences.setUser(emailController.text, value.user!.uid, role);
                                Get.offAll(taskScreen());
                              }).catchError((error){
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text("Email and Password aren't compatible",softWrap: true,style: TextStyle(fontSize: 20),),
                                  backgroundColor: Colors.redAccent,
                                  duration: Duration(seconds: 2),
                                ));
                                print(error);
                              });
                            }
                        },
                        child: Text("Login", style: TextStyle(fontSize: 20))),
                    width: double.infinity,
                    height: 50,
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have account ?",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                        SizedBox(width: 3,),
                        TextButton(onPressed: (){
                          Get.to(registerScreen());
                        }, child: Text("Register",style: TextStyle(fontSize: 19,color: Colors.lightBlueAccent),))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
