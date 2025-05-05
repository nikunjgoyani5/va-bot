class AllOffersModel {
  String imagePath;
  String title;
  String offerAmount;
  String status;
  AllOfferProfile profile;

  AllOffersModel({
    required this.imagePath,
    required this.title,
    required this.offerAmount,
    required this.profile,
    required this.status,
  });
}

class AllOfferProfile {
  String imagePath;
  String name;
  String status;

  AllOfferProfile({
    required this.imagePath,
    required this.name,
    required this.status,
  });
}
