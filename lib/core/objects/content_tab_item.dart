class ContentTabItem {
  final String tabName;
  final String objectType;
  final String listType;
  final String categoryType;
  final String partnerid;
  final String idgenre;
  final String related;

  ContentTabItem(
      {required this.tabName,
      this.objectType = "",
      this.listType = "",
      this.categoryType = "",
      this.partnerid = "",
      this.idgenre = "",
      this.related = ""});

}
