import 'dart:async';
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Common.dart';

abstract class BaseColumnSubmitState<T extends StatefulWidget>
    extends State<T> {
  Timer timer;

  int currentCodeCountDown = 0;

  HashMap<String, TextEditingController> allEditControllers;

  addEditController(String key, TextEditingController value) {
    allEditControllers.putIfAbsent(key, () => value);
  }

  TextEditingController getEditController(String key) {
    return allEditControllers[key];
  }

  void startTimerIfNeeded() {
    currentCodeCountDown = Commons.TIMER_COUNT;
    setState(() {});
    if (null == timer) {
      timer = new Timer.periodic(new Duration(seconds: 1), (timer) {
        if (hasInCountDown()) {
          currentCodeCountDown = currentCodeCountDown - 1;
        }
        setState(() {});
      });
    }
  }

  bool hasInCountDown() {
    return currentCodeCountDown > 0;
  }

  Widget getClearButton(String targetText, GestureTapCallback onTap) {
    if (targetText == null || targetText.length <= 0) {
      return null;
    }
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        Icons.cancel,
        color: Color(Commons.DEFAULT_GRAY_3),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    allEditControllers = new HashMap<String, TextEditingController>();
  }

  @override
  void dispose() {
    super.dispose();
    if (null != timer) {
      timer.cancel();
    }
    if (null != allEditControllers) {
      allEditControllers.entries.forEach((element) {
        element.value.dispose();
      });
    }
  }
}
