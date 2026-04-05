class WelcomeScreenModel {
  final int? id;
  final String? image;
  final String? titleEn;
  final String? titleAr;
  final String? order;

  WelcomeScreenModel({
    this.id,
    this.image,
    this.titleEn,
    this.titleAr,
    this.order,
  });

  factory WelcomeScreenModel.fromJson(Map<String, dynamic> json) {
    return WelcomeScreenModel(
      id: json['id'],
      image: json['image'],
      titleEn: json['title_en'],
      titleAr: json['title_ar'],
      order: json['order'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'title_en': titleEn,
      'title_ar': titleAr,
      'order': order,
    };
  }
}
