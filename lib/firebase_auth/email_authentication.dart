import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailAuthentication extends StatefulWidget {
  const EmailAuthentication({Key? key}) : super(key: key);

  @override
  State<EmailAuthentication> createState() => _EmailAuthenticationState();
}

class _EmailAuthenticationState extends State<EmailAuthentication> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String errorMessage="";
  @override
  Widget build(BuildContext context) {
    User? user=FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text("Email Authentication (Logged ${user==null?" Out":" In"})"),
      ),
      body: Center(
        child: Form(
          key: _key,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                validator: emailValidation,
              ),
              TextFormField(
                controller: passwordController,
                validator: passwordValidation,
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text(errorMessage,style: TextStyle(fontSize: 30,color: Colors.red),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async{
                       setState((){
                         errorMessage="";
                       });
                      try {
                        await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text
                        );
                        errorMessage="";
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          errorMessage=e.message!;
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          errorMessage=e.message!;
                          print('The account already exists for that email.');
                        }
                      } catch (e) {
                        print(e);
                      }
                      setState((){

                      });
                    },
                    child: Text("SignUp"),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("SignIn"),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("SignOut"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
String? emailValidation(String? email){
  if(email==null || email.isEmpty){
    return "Enter email address";
  }else{
    String pattern ='^[^@]+@[^@]+\.[^@]+';
    RegExp regex = RegExp(pattern);
    if(!regex.hasMatch(email)){
      return "Invalid email .please enter valid email";
    }

    return null;
  }
}
String? passwordValidation(String? password){
  if(password==null || password.isEmpty){
    return "Enter password";
  }else{
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    if(!regExp.hasMatch(password)){
      return "Password must be 8 characters long\n And it must have Upper letters, numbers,symbols.";
    }
    return null;
  }
}