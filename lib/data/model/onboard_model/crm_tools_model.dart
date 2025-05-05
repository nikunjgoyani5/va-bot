class CrmToolsModel {
  String imagePath;
  String title;
  void Function() onConnect;

  CrmToolsModel({
    required this.imagePath,
    required this.title,
    required this.onConnect,
  });
}
