import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myplans/pages/home_page.dart';
import 'package:myplans/pages/home_page.dart';
import 'package:myplans/services/prefs_service.dart';
import 'package:myplans/utils/const_utils.dart';
import 'package:myplans/utils/toast_utils.dart';

import 'auth_service.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {

  bool _isHiddenPassword = true;
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();

  void doLogIn(){

    String email = _emailController.text.toString().trim();
    String password = _passwordController.text.toString().trim();

    if(email.isEmpty || password.isEmpty) return;
    AuthService.signInUser(context, email, password).then((firebaseUser) => {
      _getFirebaseUser(firebaseUser)
    });
  }

 _getFirebaseUser( FirebaseUser firebaseUser) async{
  if(firebaseUser != null){
    await Prefs.saveUserId(firebaseUser.uid);
    Navigator.pushReplacementNamed(context, HomePage.id);
  }else{
    Utils.fireToast("Check your email or password!");
  }
}

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor:  Colors.grey[400],
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: _size.width * 0.117,
          ),
          child: Form(
            child: Column(
              mainAxisAlignment:  MainAxisAlignment.center,
              children: [
                Spacer(),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      hintText: "Email"
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(
                  vertical: defaultPadding,
                ),
                  child: TextFormField(
                    controller: _passwordController,
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
                ),
                SizedBox(height: 20,),
                Text("Don't have an account?", style: TextStyle(color: Colors.brown.shade600, fontSize: 17),),
                Spacer(flex: 2,),


              ],
            ),
          ),
        )
    );
  }
}