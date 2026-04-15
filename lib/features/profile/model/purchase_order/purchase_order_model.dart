class PurchaseOrderModel {
  final int id;
  final String status;
  final num quantity;
  final String listedUnitPrice;
  final String estimatedSubtotal;
  final String? distinguishingMark;
  final String? recipientPhone;
  final POLocation? location;
  final POSupplierMaterial? supplierMaterial;
  final String? createdAt;
  final String? supplierRespondedAt;
  final POQuote? supplierQuote;
  final POInvoice? invoice;
  final bool isPaid;
  final String? rejectionReason;

  PurchaseOrderModel({
    required this.id,
    required this.status,
    required this.quantity,
    required this.listedUnitPrice,
    required this.estimatedSubtotal,
    this.distinguishingMark,
    this.recipientPhone,
    this.location,
    this.supplierMaterial,
    this.createdAt,
    this.supplierRespondedAt,
    this.supplierQuote,
    this.invoice,
    this.isPaid = false,
    this.rejectionReason,
  });

  factory PurchaseOrderModel.fromJson(Map<String, dynamic> json) {
    return PurchaseOrderModel(
      id: json['id'] as int? ?? 0,
      status: json['status'] as String? ?? 'unknown',
      quantity: json['quantity'] as num? ?? 0.0,
      listedUnitPrice: json['listed_unit_price']?.toString() ?? '0.0',
      estimatedSubtotal: json['estimated_subtotal']?.toString() ?? '0.0',
      distinguishingMark: json['distinguishing_mark'] as String?,
      recipientPhone: json['recipient_phone'] as String?,
      location: json['location'] != null ? POLocation.fromJson(json['location'] as Map<String, dynamic>) : null,
      supplierMaterial: json['supplier_material'] != null ? POSupplierMaterial.fromJson(json['supplier_material'] as Map<String, dynamic>) : null,
      createdAt: json['created_at'] as String?,
      supplierRespondedAt: json['supplier_responded_at'] as String?,
      supplierQuote: json['supplier_quote'] != null ? POQuote.fromJson(json['supplier_quote'] as Map<String, dynamic>) : null,
      invoice: json['invoice'] != null ? POInvoice.fromJson(json['invoice'] as Map<String, dynamic>) : null,
      isPaid: json['is_paid'] as bool? ?? false,
      rejectionReason: json['rejection_reason'] as String?,
    );
  }
}

class POLocation {
  final String? country;
  final String? governorate;
  final String? city;

  POLocation({this.country, this.governorate, this.city});

  factory POLocation.fromJson(Map<String, dynamic> json) {
    return POLocation(
      country: json['country']?['name'] as String?,
      governorate: json['governorate']?['name'] as String?,
      city: json['city']?['name'] as String?,
    );
  }
}

class POSupplierMaterial {
  final int id;
  final String name;
  final String? supplierName;
  final String? familyName;
  final String? casNumber;

  POSupplierMaterial({
    required this.id,
    required this.name,
    this.supplierName,
    this.familyName,
    this.casNumber,
  });

  factory POSupplierMaterial.fromJson(Map<String, dynamic> json) {
    return POSupplierMaterial(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      supplierName: json['supplier']?['name'] as String?,
      familyName: json['family']?['name'] as String?,
      casNumber: json['cas_number'] as String?,
    );
  }
}

class POQuote {
  final String unitPrice;
  final String lineSubtotal;
  final String? discountAmount;
  final String? discountPercent;
  final String? discountTotal;
  final String? shippingFee;
  final String grandTotal;

  POQuote({
    required this.unitPrice,
    required this.lineSubtotal,
    this.discountAmount,
    this.discountPercent,
    this.discountTotal,
    this.shippingFee,
    required this.grandTotal,
  });

  factory POQuote.fromJson(Map<String, dynamic> json) {
    return POQuote(
      unitPrice: json['unit_price']?.toString() ?? '0.0',
      lineSubtotal: json['line_subtotal']?.toString() ?? '0.0',
      discountAmount: json['discount_amount']?.toString(),
      discountPercent: json['discount_percent']?.toString(),
      discountTotal: json['discount_total']?.toString(),
      shippingFee: json['shipping_fee']?.toString(),
      grandTotal: json['grand_total']?.toString() ?? '0.0',
    );
  }
}

class POInvoice {
  final int id;
  final String invoiceNumber;
  final String currency;
  final String grandTotal;
  final String status;

  POInvoice({
    required this.id,
    required this.invoiceNumber,
    required this.currency,
    required this.grandTotal,
    required this.status,
  });

  factory POInvoice.fromJson(Map<String, dynamic> json) {
    return POInvoice(
      id: json['id'] as int? ?? 0,
      invoiceNumber: json['invoice_number'] as String? ?? '',
      currency: json['currency'] as String? ?? 'EGP',
      grandTotal: json['grand_total']?.toString() ?? '0.0',
      status: json['status'] as String? ?? '',
    );
  }
}
