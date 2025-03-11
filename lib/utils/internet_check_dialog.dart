import 'package:flutter/cupertino.dart';

class InternetCheckAlert {
  showAlert(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text(
            "Alert!",
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF000000),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            children: [
              Text(
                "noInternet".trim(),
                style: const TextStyle(fontSize: 13, color: Color(0xFF000000)),
              ),
              const SizedBox(height: 8.0),
              Text(
                "internetRequest".trim(),
                style: const TextStyle(fontSize: 12, color: Color(0xFF000000)),
              ),
            ],
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                "ok".trim(),
                style: const TextStyle(color: Color(0xFF8280FF)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
