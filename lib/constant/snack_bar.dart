import 'package:flutter/cupertino.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

snackBar(BuildContext context, String text, Color color) {
  return showTopSnackBar(
    context,
    CustomSnackBar.info(
      message: text,
      backgroundColor: color,
    ),
  );
}
