import 'package:flutter/material.dart';

goto(context, route) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => route),
  );
}

// go back to prviuse router/screen/page
pop(BuildContext context) {
  Navigator.of(context).pop();
}
