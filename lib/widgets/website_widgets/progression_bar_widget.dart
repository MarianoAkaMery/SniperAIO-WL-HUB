import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProgressionBarSniper extends StatefulWidget {
  ProgressionBarSniper({super.key, required this.indexToDisplay});

  int indexToDisplay;

  @override
  State<ProgressionBarSniper> createState() => _ProgressionBarSniperState();
}

class _ProgressionBarSniperState extends State<ProgressionBarSniper> {
  @override
  Widget build(BuildContext context) {
    List<StepperData> stepperData = [
      StepperData(
        title: StepperText("Profiles"),
        iconWidget: Icon(Icons.check_circle_sharp,
            size: 20,
            color: widget.indexToDisplay > 0 ? Colors.green : Colors.black),
      ),
      StepperData(
        title: StepperText("Categories"),
        iconWidget: Icon(Icons.check_circle_sharp,
            size: 20,
            color: widget.indexToDisplay > 1 ? Colors.green : Colors.black),
      ),
      StepperData(
        title: StepperText("Questions"),
        iconWidget: Icon(Icons.check_circle_sharp,
            size: 20,
            color: widget.indexToDisplay > 2 ? Colors.green : Colors.black),
      ),
      StepperData(
        title: StepperText("Submit"),
        iconWidget: Icon(Icons.check_circle_sharp,
            size: 20,
            color: widget.indexToDisplay == 3 ? Colors.green : Colors.black),
      ),
    ];
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: 300,
        child: Column(
          children: [
            Image.asset(
              'lib/assets/banner-black.png',
              height: 100,
              width: 150,
              alignment: Alignment.bottomCenter,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: AnotherStepper(
                stepperList: stepperData,
                stepperDirection: Axis.horizontal,
                inverted: false,
                activeBarColor: Colors.green,
                inActiveBarColor: Colors.grey,
                activeIndex: widget.indexToDisplay,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
