import 'dart:async';

import 'package:flutter/material.dart';
import 'package:urban_aura_flutter/core/common/widgets/spacer_box.dart';
import 'package:urban_aura_flutter/core/helper/loading_dialog_controller.dart';
import 'package:urban_aura_flutter/core/theme/app_palette.dart';

class LoadingDialog {
  static final LoadingDialog _shared = LoadingDialog._();

  LoadingDialog._();

  factory LoadingDialog() => _shared;

  LoadingDialogController? _loadingDialogController;

  void show({
    required BuildContext context,
    required String text,
  }) {
    if (_loadingDialogController?.update(text) ?? false) {
      return;
    } else {
      _loadingDialogController = showOverlay(context: context, text: text);
    }
  }

  void hide() {
    _loadingDialogController?.close();
    _loadingDialogController = null;
  }

  LoadingDialogController showOverlay(
      {required BuildContext context, required text}) {
    final textController = StreamController<String>();
    textController.add(text);

    final overlayState = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;

    final renderSize = renderBox.size;

    final overlayEntry = OverlayEntry(builder: (context) {
      return Material(
        color: Colors.black.withAlpha(105),
        child: Center(
            child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
          ),
          constraints: BoxConstraints(
            maxWidth: renderSize.width * 0.5,
            minWidth: renderSize.width * 0.5,
            maxHeight: renderSize.height * 0.2,
            minHeight: renderSize.height * 0.2,
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(

                strokeWidth: 1,
                strokeCap: StrokeCap.round,
                color: AppPalette.primaryColor,
              ),
              const SpacerBox(),
              StreamBuilder(
                stream: textController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data as String,
                      overflow: TextOverflow.fade,
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        )),
      );
    });

    overlayState.insert(overlayEntry);

    LoadingDialogController controller =
        LoadingDialogController(update: (text) {
      textController.add(text);
      return true;
    }, close: () {
      textController.close();
      overlayEntry.remove();
      return true;
    });

    return controller;
  }
}
