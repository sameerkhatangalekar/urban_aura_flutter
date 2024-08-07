import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/custom_circular_progress_indicator.dart';
import 'package:urban_aura_flutter/core/helper/loading_dialog_controller.dart';

class LoadingDialog {
  static final LoadingDialog _shared = LoadingDialog._();

  LoadingDialog._();

  factory LoadingDialog() => _shared;

  LoadingDialogController? _loadingDialogController;

  void show({
    required BuildContext context,
    String text = 'Please wait',
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
      {required BuildContext context, required String text}) {
    final textController = StreamController<String>();
    textController.add(text);

    final overlayState = Overlay.of(context);

    Size? size;
    final renderObj = context.findRenderObject();
    if (renderObj is RenderBox) {
      size = renderObj.size;
    } else if (renderObj is RenderSliverList) {
      size = Size(renderObj.constraints.crossAxisExtent,
          renderObj.constraints.viewportMainAxisExtent);
      debugPrint('Im using sliver constraints');

    } else {
      size = const Size(400, 600);
    }



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
            maxWidth: size!.width * 0.5,
            minWidth: size.width * 0.5,
            maxHeight: size.height * 0.2,
            minHeight: size.height * 0.2,
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomCircularProgressIndicator(),
              const SizedBox(
                height: 8,
              ),
              StreamBuilder(
                stream: textController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data as String,
                      overflow: TextOverflow.fade,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.black),
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
