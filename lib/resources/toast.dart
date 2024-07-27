
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';



void toast(String? msg, {bool long = false, Alignment? alignment, bool? success}) {
  alignment ??= Alignment.topRight;
  // CancelFunc? cancel;
  BotToast.showCustomText(
    animationDuration: const Duration(milliseconds: 200),
    animationReverseDuration: const Duration(milliseconds: 250),
    align: alignment,
    backButtonBehavior: BackButtonBehavior.close,
    duration: Duration(milliseconds: long ? 4000 : 3000),
    clickClose: false,
    crossPage: true,
    onlyOne: false,
    toastBuilder: (_) {
      return 
      Container(
        decoration: BoxDecoration(
          color: success == null
              ? const Color(0xFF323232)
              : success
                  ? Colors.green
                  : Colors.red,
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        constraints: const BoxConstraints(
          maxWidth: 400.0,
          minWidth: 350.0,
        ),
        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
        child: Material(
          color: Colors.transparent,
          child: ListTile(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                success == null
                    ? Icons.info_outline
                    : success
                        ? Icons.task_alt
                        : Icons.error_outline,
                color: Colors.white,
              ),
            ),
            minLeadingWidth: 8,
            horizontalTitleGap: 8,
            title: Text(
              (msg ?? ''),
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      );
    },
  );
}

CancelFunc _loader() {
  return BotToast.showCustomLoading(
    toastBuilder: (_) => const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      strokeWidth: 2,
    ),
    animationDuration: const Duration(milliseconds: 400),
    animationReverseDuration: const Duration(milliseconds: 400),
    backButtonBehavior: BackButtonBehavior.ignore,
    crossPage: true,
    backgroundColor: Colors.black45,
    ignoreContentClick: true,
  );
}

void showLoader() {
  _loader();
}

void hideLoader() {
  BotToast.closeAllLoading();
}