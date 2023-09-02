import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomProgressDialog extends StatelessWidget {
  final String message;
  final Future<void> loadingFuture;

  CustomProgressDialog({
    required this.message,
    required this.loadingFuture,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: FutureBuilder(
        future: loadingFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the future has completed, close the dialog.
            Navigator.of(context).pop();
          }
          return _buildDialogContent();
        },
      ),
    );
  }

  Widget _buildDialogContent() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset("assets/loading.json", height: 200),
          SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

void showCustomProgressDialog(BuildContext context, String message) {
  final loadingFuture = Future.delayed(Duration(seconds: 20));
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return CustomProgressDialog(
        message: message,
        loadingFuture: loadingFuture,
      );
    },
  );
}
