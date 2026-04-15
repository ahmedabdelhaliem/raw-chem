class PaymentMethodModel {
  final int paymentId;
  final String paymentCode;
  final String paymentMethod;

  PaymentMethodModel({
    required this.paymentId,
    required this.paymentCode,
    required this.paymentMethod,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      paymentId: json['paymentId'] ?? 0,
      paymentCode: json['paymentCode'] ?? '',
      paymentMethod: json['paymentMethod'] ?? '',
    );
  }
}
