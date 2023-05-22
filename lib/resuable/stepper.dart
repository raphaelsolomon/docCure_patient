import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NumberStepper extends StatelessWidget {
  final double width;
  final int totalSteps;
  final int curStep;
  final Color stepCompleteColor;
  final Color currentStepColor;
  final Color inactiveColor;
  final double lineWidth;
  final List<String> text;
  final Function callBack;

  const NumberStepper({
    Key? key,
    required this.width,
    required this.curStep,
    required this.stepCompleteColor,
    required this.totalSteps,
    required this.inactiveColor,
    required this.currentStepColor,
    required this.lineWidth,
    required this.text,
    required this.callBack,
  })  : assert(curStep > 0 == true && curStep <= totalSteps + 1),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 5.0,
        left: 5.0,
        right: 5.0,
      ),
      width: width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: text.map((e) => Text(e, style: GoogleFonts.poppins(fontSize: 11.0, color: Colors.black45))).toList(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: _steps(),
            ),
          ),
        ],
      ),
    );
  }

  getCircleColor(i) {
    Color color;
    if (i + 1 <= curStep) {
      color = stepCompleteColor;
    } else if (i + 1 == curStep) {
      color = currentStepColor;
    } else {
      color = const Color(0xFF878787);
    }
    return color;
  }

  getBorderColor(i) {
    Color color;
    if (i + 1 <= curStep) {
      color = stepCompleteColor;
    } else if (i + 1 == curStep) {
      color = currentStepColor;
    } else {
      color = inactiveColor;
    }
    return color;
  }

  getLineColor(i) {
    var color = curStep > i + 1 ? Colors.green.withOpacity(0.4) : const Color(0xFF878787);
    return color;
  }

  List<Widget> _steps() {
    var list = <Widget>[];
    for (int i = 0; i < totalSteps; i++) {
      //colors according to state

      var circleColor = getCircleColor(i);
      var borderColor = getBorderColor(i);
      var lineColor = getLineColor(i);

      // step circles
      list.add(
        GestureDetector(
          onTap: () => callBack(i),
          child: Container(
            width: 25.0,
            height: 25.0,
            child: getInnerElementOfStepper(i),
            decoration: BoxDecoration(
              color: circleColor,
              borderRadius: const BorderRadius.all(Radius.circular(25.0)),
              border: Border.all(
                color: borderColor,
                width: 1.0,
              ),
            ),
          ),
        ),
      );

      //line between step circles
      if (i != totalSteps - 1) {
        list.add(
          Expanded(
            child: Container(
              height: lineWidth,
              color: lineColor,
            ),
          ),
        );
      }
    }

    return list;
  }

  Widget getInnerElementOfStepper(index) {
    if (index + 1 <= curStep) {
      return const Icon(
        Icons.check,
        color: Colors.white,
        size: 15.0,
      );
    } else if (index + 1 == curStep) {
      return const Icon(
        Icons.circle,
        color: Colors.white,
        size: 15.0,
      );
    } else {
      return Icon(
        Icons.circle,
        color: Colors.grey.shade200,
        size: 15.0,
      );
    }
  }
}
