import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myplans/pages/home_page.dart';
import 'package:myplans/services/login_service.dart';
import 'package:myplans/services/signnUp_service.dart';
import 'package:myplans/utils/const_utils.dart';

class RegisterPage  extends StatefulWidget  {

  static final String id = "regist_page";

  @override
  _RegisterPageState createState() => _RegisterPageState();
}


class _RegisterPageState extends State<RegisterPage>  with SingleTickerProviderStateMixin {

  bool _isShowSignUp = false;

  AnimationController _animationController;
  Animation<double> _animationTextRotate;

  void setUpAnimation(){
    _animationController = AnimationController(vsync: this, duration: defaultDuration);

    _animationTextRotate = Tween<double>(begin: 0, end: 90).animate(_animationController);
  }

  @override
  void initState() {
    // TODO: implement initState
    setUpAnimation();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }
  void updateView(){
    setState(() {
      _isShowSignUp = !_isShowSignUp;
    });
    _isShowSignUp ? _animationController.forward():
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {

    final _size = MediaQuery.of(context).size;

    return Scaffold(
        body: AnimatedBuilder(
            animation: _animationController,
            builder: (context, snapshot) {
              return Stack(
                children: [
                  AnimatedPositioned(
                    duration: defaultDuration,
                    height: _size.height ,
                    width: _size.width * 0.88 ,
                    left: _isShowSignUp ? -_size.width * 0.76 : 0,
                    child: Container(
                      child: LoginWidget(),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: defaultDuration,
                    height: _size.height ,
                    width: _size.width * 0.88,
                    left: _isShowSignUp ?_size.width * 0.12 : _size.width * 0.88,
                    child: Container(
                      child: SignUpwidget(),
                    ),
                  ),

                  AnimatedPositioned(
                      duration: defaultDuration,
                      left: 0,
                      right: _isShowSignUp ? _size.width * 0.06 : _size.width * 0.06,
                      top: _size.height * 0.1,
                      child:  AnimatedSwitcher(
                        duration: defaultDuration,
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 3,
                                color: !_isShowSignUp?  Colors.brown.shade400 : Colors.grey.shade400,
                              ),
                              image: DecorationImage(
                                image: AssetImage("assets/images/logo_my_plans.png"),
                              )
                          ),
                        ),
                      )
                  ),
                  AnimatedPositioned(
                    duration: defaultDuration,
                    bottom: _isShowSignUp ? _size.height /2 - 80 :
                    _size.height * 0.3,
                    left: _isShowSignUp? 0 : _size.width * 0.44 - 60,
                    child:  Transform.rotate(
                      angle: -_animationTextRotate.value * pi /180 ,
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: (){
                          if(_isShowSignUp){
                            updateView();
                          }else{
                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                              return HomePage();
                            }));
                            //login
                            LoginWidget().createState().doLogIn();
                          }
                        },
                        child: Container(
                          padding:  const EdgeInsets.symmetric(
                              vertical: defaultPadding * 0.75
                          ),
                          width: 160,
                          child: Text("LOG IN",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: _isShowSignUp ? Colors.brown : Colors.brown.shade400,
                                fontWeight: FontWeight.bold,
                                fontSize: _isShowSignUp ? 22 : 32
                            ),),
                        ),
                      ),
                    ),
                  ),

                  AnimatedPositioned(
                    duration: defaultDuration,
                    bottom: !_isShowSignUp ? _size.height /2 - 80 :
                    _size.height * 0.3,
                    right: _isShowSignUp? _size.width * 0.44 - 60 : 0,
                    child:  Transform.rotate(
                      angle: (90-_animationTextRotate.value) * pi /180 ,
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: (){
                          if(_isShowSignUp){
                            print("hello");
                            Navigator.pushReplacementNamed(context, HomePage.id);
                         // SignUpwidget().createState().doSignUp();
                          }else{
                            updateView();
                          }
                        },
                        child: Container(
                          padding:  const EdgeInsets.symmetric(
                              vertical: defaultPadding * 0.75
                          ),
                          width: 160,
                          child: Text("Sign Up".toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: _isShowSignUp ? Colors.grey.shade400 : Colors.grey.shade300,
                                fontWeight: FontWeight.bold,
                                fontSize: !_isShowSignUp ? 22 : 32
                            ),),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
        )
    );
  }
}

