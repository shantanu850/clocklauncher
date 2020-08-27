import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class SpinnerText extends StatefulWidget {
  SpinnerText({@required this.text, this.textStyle, this.animationStyle})
      : assert(text != null);

  final String text;
  final TextStyle textStyle;
  final Curve animationStyle;

  _SpinnerTextState createState() => _SpinnerTextState();
}

class _SpinnerTextState extends State<SpinnerText>
    with SingleTickerProviderStateMixin {
  String topText = "";
  String bottomText = "";

  AnimationController _spinTextAnimationController;
  Animation<double> _spinAnimation;

  @override
  void initState() {
    super.initState();
    bottomText = widget.text;
    _spinTextAnimationController = new AnimationController(
        duration: const Duration(milliseconds: 750), vsync: this)
      ..addListener(() => setState(() {}))
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            bottomText = topText;
            topText = "";
            _spinTextAnimationController.value = 0.0;
          });
        }
      });

    _spinAnimation = CurvedAnimation(
        parent: _spinTextAnimationController,
        curve: widget.animationStyle == null
            ? Curves.decelerate
            : widget.animationStyle);
  }

  @override
  void dispose() {
    super.dispose();
    _spinTextAnimationController.dispose();
  }

  @override
  void didUpdateWidget(SpinnerText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.text != oldWidget.text) {
      //Need to spin new value
      topText = widget.text;
      _spinTextAnimationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      clipper: RectClipper(),
      child: Stack(
        children: <Widget>[
          FractionalTranslation(
            translation: Offset(0.0, _spinAnimation.value - 1.0),
            child: AutoSizeText(
              topText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: widget.textStyle != null
                  ? widget.textStyle
                  : TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
          FractionalTranslation(
            translation: Offset(0.0, _spinAnimation.value),
            child: AutoSizeText(bottomText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: widget.textStyle != null
                    ? widget.textStyle
                    : TextStyle(color: Colors.white, fontSize: 30)),
          ),
        ],
      ),
    );
  }
}

class RectClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0.0, 0.0, size.width, size.height + 1);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}