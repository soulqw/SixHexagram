import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sixflutter/BaseColumnSubmitState.dart';

import 'Common.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegisterHome(context),
    );
  }
}

class RegisterHome extends StatefulWidget {
  // This widget is the root of your application.
  BuildContext pageContext;

  RegisterHome(this.pageContext);

  @override
  State<StatefulWidget> createState() {
    return RegisterState(pageContext);
  }
}

class RegisterState extends BaseColumnSubmitState<RegisterHome> {
  String NUMBER_CONTROLLER = "number_controller";

  String NAME_CONTROLLER = "name_controller";

  String CODE_CONTROLLER = "code_controller";

  bool canRegister = false;

  bool isEditingIdCard = false;

  BuildContext context;

  RegisterState(this.context);

  String numberInput;

  String nameInput;

  String idCardInput;

  String codeInput;

  FocusNode _focusNodeIdCard;

  @override
  void initState() {
    super.initState();
    addEditController(NUMBER_CONTROLLER, TextEditingController());
    addEditController(NAME_CONTROLLER, TextEditingController());
    addEditController(CODE_CONTROLLER, TextEditingController());
    _focusNodeIdCard = new FocusNode();
    _focusNodeIdCard.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    int registerButtonColor =
        canRegister ? Commons.DEFAULT_BLUE : Commons.DEFAULT_BLUE_2;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          '注册',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: new Container(
          margin: EdgeInsets.all(5),
          child: new InkWell(
            borderRadius: BorderRadius.circular(64.0),
            onTap: () {
              Navigator.pop(this.context);
            },
            child: new Container(
                width: 22,
                height: 22,
                child: new Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xFF2f81FC),
                  size: 22,
                )),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsetsDirectional.only(start: 36, top: 40, end: 36),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[
                Text(
                  '手机号',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                TextField(
                  controller: getEditController(NUMBER_CONTROLLER),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    WhitelistingTextInputFormatter(RegExp("[0-9]")),
                  ],
                  textAlign: TextAlign.left,
                  expands: false,
                  decoration: Commons.getEditInputDecoration(
                      EdgeInsets.only(left: 84),
                      "输入手机号",
                      TextStyle(
                          fontSize: 16, color: Color(Commons.DEFAULT_GRAY))),
                  onChanged: (String text) {
                    numberInput = text;
                    checkInputContents();
                  },
                ),
                Container(
                    alignment: Alignment.centerRight,
                    child: getClearButton(numberInput, () {
                      numberInput = '';
                      getEditController(NUMBER_CONTROLLER).clear();
                      checkInputContents();
                    }))
              ],
            ),
            Text(
              ' ',
              style:
                  TextStyle(fontSize: 11, color: Color(Commons.DEFAULT_RED_1)),
            ),
            Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[
                Text(
                  '真实姓名',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                TextField(
                    keyboardType: TextInputType.phone,
                    controller: getEditController(NAME_CONTROLLER),
                    textAlign: TextAlign.left,
                    decoration: Commons.getEditInputDecoration(
                        EdgeInsets.only(left: 84),
                        "输入您的姓名",
                        TextStyle(
                            fontSize: 16, color: Color(Commons.DEFAULT_GRAY))),
                    onChanged: (String text) {
                      nameInput = text;
                      checkInputContents();
                    }),
                Container(
                    alignment: Alignment.centerRight,
                    child: getClearButton(nameInput, () {
                      nameInput = '';
                      getEditController(NAME_CONTROLLER).clear();
                      checkInputContents();
                    }))
              ],
            ),
            Text(
              ' ',
              style:
                  TextStyle(fontSize: 11, color: Color(Commons.DEFAULT_RED_1)),
            ),
            Stack(
              children: <Widget>[
                Container(
                    height: 48,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '身份证号',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    )),
                TextField(
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 84),
                      hintText: "数字开头的18位号码",
                      hintStyle: TextStyle(
                          fontSize: 16, color: Color(Commons.DEFAULT_GRAY))),
                  onChanged: (String text) {
                    idCardInput = text;
                    checkInputContents();
                  },
                  focusNode: _focusNodeIdCard,
                ),
                Container(
                    height: 50,
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      '为保证配送服务安全监管，请如实填写身份证号',
                      style: TextStyle(
                          fontSize: 11, color: Color(Commons.DEFAULT_GRAY)),
                    )),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 4, bottom: 12),
              height: 1.2,
              color: Color(_focusNodeIdCard.hasFocus
                  ? Commons.DEFAULT_BLUE
                  : Commons.DEFAULT_GRAY_2),
            ),
            Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[
                Text(
                  '验证码',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                TextField(
                    controller: getEditController(CODE_CONTROLLER),
                    textAlign: TextAlign.left,
                    decoration: Commons.getEditInputDecoration(
                        EdgeInsets.only(left: 84),
                        "输入验证码",
                        TextStyle(
                            fontSize: 16, color: Color(Commons.DEFAULT_GRAY))),
                    onChanged: (String text) {
                      codeInput = text;
                      checkInputContents();
                    },
                    keyboardType: TextInputType.number),
                Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(right: 104),
                    child: getClearButton(codeInput, () {
                      codeInput = '';
                      getEditController(CODE_CONTROLLER).clear();
                      checkInputContents();
                    })),
                Container(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      sendValidationCode();
                    },
                    child: Text(
                      getCodeTextDesc(),
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontSize: 16, color: Color(getCodeTextColor())),
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                doRegister();
              },
              child: Container(
                margin: EdgeInsetsDirectional.only(top: 39),
                width: double.infinity,
                height: 44,
                alignment: AlignmentDirectional.center,
                decoration: ShapeDecoration(
                    color: Color(registerButtonColor),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)))),
                child: Text(
                  '注册',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void checkInputContents() {
    canRegister = Commons.isNotEmpty(nameInput) &&
        Commons.isNotEmpty(idCardInput) &&
        Commons.isNotEmpty(codeInput) &&
        hasInputAnNumber();
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
    return hasInputAnNumber() && !hasInCountDown();
  }

  bool hasInputAnNumber() {
    return numberInput != null && numberInput.length > 10;
  }

  void doRegister() {
    if (!canRegister) {
      print('do not register');
    }
    //todo
  }

  @override
  void dispose() {
    if (null != _focusNodeIdCard) {
      _focusNodeIdCard.dispose();
    }
    super.dispose();
  }

}
