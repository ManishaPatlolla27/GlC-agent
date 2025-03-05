import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ValidationIoSAlert {
  showAlert(BuildContext context, {required String? description, bool? flag}) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Column(
            children: <Widget>[
              Icon(
                CupertinoIcons.info_circle,
                size: 60.0,
                color: Colors.black,
              ),
              SizedBox(height: 8.0),
            ],
          ),
          content: Column(
            children: [
              const SizedBox(height: 8.0),
              Text(
                "$description",
                style: const TextStyle(fontSize: 12, color: Colors.black),
              ),
            ],
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text(
                "Ok",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                if (flag ?? false) {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
