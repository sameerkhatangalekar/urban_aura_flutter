typedef CloseLoadingScreen = bool Function();
typedef UpdateLoadingScreen = bool Function(String text);

class LoadingDialogController {
  final CloseLoadingScreen close;
  final UpdateLoadingScreen update;

  LoadingDialogController({required this.close, required this.update});
}
