class BannerModel {
  final String? banner;

  BannerModel({this.banner});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      banner: json['banner'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'banner': banner,
    };
  }
}
