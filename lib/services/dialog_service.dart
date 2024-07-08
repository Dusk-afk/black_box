import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogAction {
  final String text;
  final VoidCallback onPressed;
  final bool destructive;

  DialogAction({
    required this.text,
    required this.onPressed,
    this.destructive = false,
  });
}

class DialogService {
  static showErrorDialog(BuildContext context, dynamic error) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text("Error"),
            content: Text(error.toString()),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              )
            ],
          ));

  static showLoadingDialog(BuildContext context,
          {String? title, bool dismissable = false}) =>
      showDialog(
          context: context,
          barrierDismissible: dismissable,
          builder: (context) => WillPopScope(
                onWillPop: () async => dismissable,
                child: AlertDialog(
                  title: Row(
                    children: [
                      const CircularProgressIndicator.adaptive(),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(title ?? "Loading"),
                    ],
                  ),
                ),
              ));

  static showYesNoDialog(BuildContext context,
          {String title = "Confirm", String message = "Are you sure?"}) =>
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(
                  title,
                  style: const TextStyle(
                      fontFamily: "segoe", fontWeight: FontWeight.w600),
                ),
                content: Text(
                  message,
                  style: const TextStyle(fontFamily: "segoe"),
                ),
                actions: [
                  MaterialButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text("No"),
                    shape: const StadiumBorder(),
                  ),
                  MaterialButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text("Yes"),
                    color: const Color(0xFF2EB2EC),
                    textColor: Colors.white,
                    shape: const StadiumBorder(),
                  ),
                  const SizedBox(
                    width: 5,
                  )
                ],
              ));

  static showOkDialog(
    BuildContext context, {
    String? title,
    required String message,
  }) =>
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: title == null
                    ? null
                    : Text(
                        title,
                        style: const TextStyle(
                            fontFamily: "segoe", fontWeight: FontWeight.w600),
                      ),
                content: Text(
                  message,
                  style: const TextStyle(fontFamily: "segoe"),
                ),
                actions: [
                  MaterialButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Ok"),
                    color: const Color(0xFF2EB2EC),
                    textColor: Colors.white,
                    shape: const StadiumBorder(),
                  ),
                  const SizedBox(
                    width: 5,
                  )
                ],
              ));

  static Widget _adaptiveAction(BuildContext context, DialogAction action) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return CupertinoDialogAction(
        onPressed: action.onPressed,
        child: Text(
          action.text,
          style: TextStyle(
            color: action.destructive ? Colors.red : Colors.blue,
          ),
        ),
      );
    } else {
      return TextButton(
          onPressed: action.onPressed,
          child: Text(
            action.text,
            style: TextStyle(
              color: action.destructive ? Colors.red : Colors.blue,
            ),
          ));
    }
  }

  static Future showAdaptiveAlertDialog<T>(
    BuildContext context, {
    required String title,
    required String message,
    required List<DialogAction> actions,
    bool barrierDismissible = true,
  }) async {
    return showAdaptiveDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => AlertDialog.adaptive(
        title: Text(title),
        content: Text(message),
        actions: actions.map((e) => _adaptiveAction(context, e)).toList(),
      ),
    );
  }
}
