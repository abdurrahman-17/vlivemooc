class BookState {
  String buttonState;
  bool isLoading;
  bool isDisabled;
  static const String login = "Login and book";
  static const String book = "Book Session";
  static const String unavailable = "Unavailable";
  BookState(
      {required this.buttonState,
      required this.isLoading,
      this.isDisabled = false});
}
