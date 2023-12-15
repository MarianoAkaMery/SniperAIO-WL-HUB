import 'package:flutter/material.dart';

class FunctionExecutingWidget extends StatefulWidget {
  final Function functionToExecute;

  FunctionExecutingWidget({required this.functionToExecute});

  @override
  _FunctionExecutingWidgetState createState() =>
      _FunctionExecutingWidgetState();
}

class _FunctionExecutingWidgetState extends State<FunctionExecutingWidget> {
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();

    super.initState();

    // Execute the function when the widget is built
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
