
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myplans/pages/home_page.dart';
import 'package:myplans/services/prefs_service.dart';
import 'package:myplans/utils/const_utils.dart';
import 'package:myplans/utils/toast_utils.dart';

import 'auth_service.dart';


class SignUpwidget extends StatefulWidget {

  @override
  _SignUpwidgetState createState() => _SignUpwidgetState();
}
class _SignUpwidgetState extends State<SignUpwidget> {

  bool _isHiddenPassword = true;

  var   _fullNameController = TextEditingController();
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();

  doSignUp(BuildContext context) {
    String name = _fullNameController.text.toString().trim();
    String email = _emailController.text.toString().trim();
    String password = _passwordController.text.toString().trim();
    print("flutter");
      Navigator.pushReplacementNamed(context, HomePage.id);
    // if(email.isEmpty || password.isEmpty || name.isEmpty) return;
    // AuthService.signUpUser(context,name,  email, password).then((firebaseUser) => {
    //   _getFirebaseUser(firebaseUser)
    // });
  }
  _getFirebaseUser( FirebaseUser firebaseUser) async{
    if(firebaseUser != null){
      await Prefs.saveUserId(firebaseUser.uid);
      Navigator.pushReplacementNamed(context, HomePage.id);
    }else{
      Utils.fireToast("Check your informations!");
    }
  }
  @override
  Widget build(BuildContext context) {

    final _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.brown.shade400,
      body:  Padding(
        padding: EdgeInsets.symmetric(
          horizontal: _size.width * 0.119,
        ),
        child: Form(
          child: Column(
            mainAxisAlignment:  MainAxisAlignment.center,
            children: [
              Spacer(),
              SizedBox(height: 20,),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "FullName"
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: defaultPadding
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: "Email"
                  ),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Password",
                  suffixIcon: IconButton(
                    onPressed: (){
                      setState(() {
                        _isHiddenPassword = !_isHiddenPassword;
                      });
                    },
                    icon: Icon(_isHiddenPassword? Icons.visibility : Icons.visibility_off),
                  ),
                ),
                obscureText: _isHiddenPassword,
              ),
              SizedBox(height: 20,),
              Text("Already have an account?", style: TextStyle(color: Colors.grey.shade300, fontSize: 17),),
              Spacer(flex: 2,),
            ],
          ),
        ),
      ),
    );
  }
}

