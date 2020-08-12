import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

import 'BaseColumnSubmitState.dart';
import 'Common.dart';
import 'Register.dart';

void main() {
  runApp(new LoginPage());
}

class LoginPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new LoginHome(),
    );
  }
}

class LoginHome extends StatefulWidget {
  LoginHome({Key key}) : super(key: key);

  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends BaseColumnSubmitState<LoginHome> {
  bool canLogin;

  String numberInput;

  String codeInput;

  @override
  void initState() {
    super.initState();
    canLogin = false;
    numberInput = '';
    codeInput = '';
  }

  @override
  Widget build(BuildContext context) {
    //blue1-blue2
    int loginButtonColor =
        canLogin ? Commons.DEFAULT_BLUE : Commons.DEFAULT_BLUE_2;
    return new Scaffold(
      body: new Container(
          child: Container(
              padding: EdgeInsetsDirectional.only(start: 36, top: 76, end: 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('您好，欢迎加入至冠配送',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                  Container(
                    margin: EdgeInsetsDirectional.only(top: 13),
                    child: Row(
                      children: <Widget>[
                        Text(
                          '新用户点击',
                          style: TextStyle(color: Color(Commons.DEFAULT_GRAY)),
                        ),
                        GestureDetector(
                          child: Text(
                            ' 免费注册',
                            style:
                                TextStyle(color: Color(Commons.DEFAULT_BLUE)),
                          ),
                          onTap: () {
                            goRegister();
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.only(top: 76),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "手机号",
                          hintStyle: TextStyle(
                              fontSize: 16,
                              color: Color(Commons.DEFAULT_GRAY))),
                      onChanged: (String text) {
                        numberInput = text;
                        checkInputContents();
                      },
                      inputFormatters: [
                        WhitelistingTextInputFormatter(RegExp("[0-9]")),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.only(top: 28),
                    child: Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: <Widget>[
                        TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "验证码",
                              hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: Color(Commons.DEFAULT_GRAY))),
                          onChanged: (String text) {
                            codeInput = text;
                            checkInputContents();
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            sendValidationCode();
                          },
                          child: Text(
                            getCodeTextDesc(),
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 16, color: Color(getCodeTextColor())),
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      doLogin();
                    },
                    child: Container(
                      margin: EdgeInsetsDirectional.only(top: 39),
                      width: double.infinity,
                      height: 44,
                      alignment: AlignmentDirectional.center,
                      decoration: ShapeDecoration(
                          color: Color(loginButtonColor),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)))),
                      child: Text(
                        '登陆',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  )
                ],
              ))),
      backgroundColor: Colors.white,
    );
  }

  bool hasInputAnNumber(String phoneNumber) {
    return phoneNumber != null && phoneNumber.length > 10;
  }

  void goRegister() {
    //todo go register
    print("goRegister");
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Register()));
  }

  void checkInputContents() {
    canLogin = Commons.isNotEmpty(codeInput) && hasInputAnNumber(numberInput);
    setState(() {});
  }

  void sendValidationCode() {
    if (!canSendVerifyCode()) {
      print("can not sendValidationCode");
      return;
    }
    //todo get Code Http
    //start timer
   startTimerIfNeeded();
  }

  String getCodeTextDesc() {
    if (hasInCountDown()) {
      return '重新发送($currentCodeCountDown)';
    }
    return '获取验证码';
  }

  int getCodeTextColor() {
    //blue-gray
    int verifyCodeColor =
        canSendVerifyCode() ? Commons.DEFAULT_BLUE : Commons.DEFAULT_GRAY_2;
    return verifyCodeColor;
  }

  bool canSendVerifyCode() {
    return hasInputAnNumber(numberInput) && !hasInCountDown();
  }

  void doLogin() {
    if (!canLogin) {
      print("can not Login");
      return;
    }
    print("doLogin");
    //todo realLogin
  }

}
