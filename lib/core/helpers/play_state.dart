class PlayState {
  String buttonState;
  bool isLoading;
  bool disabled;
  String buttonText;

  static const String boxedButton = "boxedButton";
  static const String shortcutButton = "shortcutButton";

  PlayState(
      {required this.buttonState,
      required this.isLoading,
      this.buttonText = "",
      this.disabled = false});
}
