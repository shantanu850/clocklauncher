import 'dart:async';
import 'package:flutter/material.dart';
import 'clock_model.dart';
import 'spinner_text.dart';

class DigitalClock extends StatefulWidget {
  DigitalClock({
    this.is24HourTimeFormat,
    this.showSecondsDigit,
    this.areaWidth,
    this.areaHeight,
    this.areaDecoration,
    this.areaAligment,
    this.hourMinuteDigitDecoration,
    this.secondDigitDecoration,
    this.digitAnimationStyle,
    this.hourMinuteDigitTextStyle,
    this.secondDigitTextStyle,
    this.amPmDigitTextStyle,
  });

  final bool is24HourTimeFormat;
  final bool showSecondsDigit;
  final double areaWidth;
  final double areaHeight;
  final BoxDecoration areaDecoration;
  final AlignmentDirectional areaAligment;
  final BoxDecoration hourMinuteDigitDecoration;
  final BoxDecoration secondDigitDecoration;
  final Curve digitAnimationStyle;
  final TextStyle hourMinuteDigitTextStyle;
  final TextStyle secondDigitTextStyle;
  final TextStyle amPmDigitTextStyle;

  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  DateTime _dateTime;
  ClockModel _clockModel;
  @override
  void initState() {
    super.initState();
    _dateTime = DateTime.now();
    _clockModel = ClockModel();
    _clockModel.is24HourFormat =
        widget.is24HourTimeFormat != null ? widget.is24HourTimeFormat : true;

    _dateTime = DateTime.now();
    _clockModel.hour = _dateTime.hour;
    _clockModel.minute = _dateTime.minute;
    _clockModel.second = _dateTime.second;
    _clockModel.day = _dateTime.day;
    _clockModel.week =_dateTime.year;
    _clockModel.month = _dateTime.month;

    Timer.periodic(Duration(seconds: 1), (timer) {
      _dateTime = DateTime.now();
      _clockModel.hour = _dateTime.hour;
      _clockModel.minute = _dateTime.minute;
      _clockModel.second = _dateTime.second;
      _clockModel.day = _dateTime.day;
      _clockModel.week =_dateTime.year;
      _clockModel.month = _dateTime.month;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Container(
      child: Container(
        alignment:Alignment.bottomCenter,
        decoration:BoxDecoration(
                border: Border.all(color: Colors.transparent),
              ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: width*0.2,
                  height:height*0.45,
                  decoration: widget.hourMinuteDigitDecoration != null
                      ? widget.hourMinuteDigitDecoration
                      : BoxDecoration(
                      borderRadius: BorderRadius.circular(5)),
                  child: SpinnerText(
                    text: _clockModel.is24HourTimeFormat
                        ? hTOhh_24hTrue(_clockModel.hour)
                        : hTOhh_24hFalse(_clockModel.hour)[0],
                    animationStyle: widget.digitAnimationStyle,
                    textStyle: widget.hourMinuteDigitTextStyle == null
                        ? null
                        : widget.hourMinuteDigitTextStyle,
                  ),
                ),
                Container(
                    width: width*0.05,
                    height:height*0.45,
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: SpinnerText(
                      text: ":",
                      textStyle: widget.hourMinuteDigitTextStyle == null
                          ? null
                          : widget.hourMinuteDigitTextStyle,
                    )),
                Container(
                  width: width*0.2,
                  height:height*0.45,
                  decoration: widget.hourMinuteDigitDecoration != null
                      ? widget.hourMinuteDigitDecoration
                      : BoxDecoration(
                  ),
                  child: SpinnerText(
                    text: mTOmm(_clockModel.minute),
                    animationStyle: widget.digitAnimationStyle,
                    textStyle: widget.hourMinuteDigitTextStyle == null
                        ? null
                        : widget.hourMinuteDigitTextStyle,
                  ),
                ),
                Container(
                  width: width*0.12,
                  height:height*0.45,
                  child: Container(
                    height:height*0.3,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _clockModel.is24HourTimeFormat
                            ? Text("")
                            : Container(
                          width:width*0.07,
                          padding: EdgeInsets.symmetric(horizontal:1),
                          child: Text(
                            hTOhh_24hFalse(_clockModel.hour)[1],
                            style: widget.amPmDigitTextStyle != null
                                ? widget.amPmDigitTextStyle
                                : TextStyle(
                                fontSize: widget.hourMinuteDigitTextStyle != null
                                    ? widget.hourMinuteDigitTextStyle.fontSize / 2
                                    : 15,
                                color: widget.hourMinuteDigitTextStyle != null
                                    ? widget.hourMinuteDigitTextStyle.color
                                    : Colors.white),
                          ),
                        ),
                        widget.showSecondsDigit != false
                            ? Container(
                          alignment: Alignment.bottomCenter,
                                width:width*0.08,
                                decoration: widget.secondDigitDecoration != null
                                    ? widget.secondDigitDecoration
                                    : BoxDecoration(
                                ),
                                child: SpinnerText(
                                  text: sTOss(_clockModel.second),
                                  animationStyle: widget.digitAnimationStyle,
                                  textStyle: widget.secondDigitTextStyle == null
                                      ? TextStyle(
                                          fontSize: widget.hourMinuteDigitTextStyle != null
                                              ? widget.hourMinuteDigitTextStyle.fontSize / 2
                                              : 15,
                                          color: widget.hourMinuteDigitTextStyle != null
                                              ? widget.hourMinuteDigitTextStyle.color
                                              : Colors.white)
                                      : widget.secondDigitTextStyle,
                                ),
                              )
                            : Text(""),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: height*0.18,
              width: width*0.5,
              child: Row(
                children: [
                  SpinnerText(
                    text: dTOdd(_clockModel.day),
                    animationStyle: widget.digitAnimationStyle,
                    textStyle: widget.secondDigitTextStyle == null
                        ? null
                        : widget.secondDigitTextStyle,
                  ),
                  SizedBox(width:5),
                  SpinnerText(
                    text: moTOmo(_clockModel.month),
                    animationStyle: widget.digitAnimationStyle,
                    textStyle: widget.secondDigitTextStyle == null
                        ? null
                        : widget.secondDigitTextStyle,
                  ),
                  SizedBox(width:5),
                  SpinnerText(
                    text: wTOww(_clockModel.week),
                    animationStyle: widget.digitAnimationStyle,
                    textStyle: widget.secondDigitTextStyle == null
                        ? null
                        : widget.secondDigitTextStyle,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
