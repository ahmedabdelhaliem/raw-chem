class OrderStatuses {
  // Common API Statuses
  static const String pending = "pending";
  static const String accepted = "accepted";
  static const String awaitingPayment = "awaiting_payment";
  static const String completed = "completed";
  static const String rejected = "rejected";
  static const String cancelled = "cancelled";
  static const String failed = "failed";

  // Groups for UI
  static const List<String> pendingTab = [
    pending,
    'pending_supplier',
  ];

  static const List<String> acceptedTab = [
    accepted,
    awaitingPayment,
    completed,
  ];

  static const List<String> rejectedTab = [
    rejected,
    cancelled,
    failed,
  ];

  static const List<String> currentOrders = [
    pending,
    accepted,
    awaitingPayment,
    'pending_supplier', // backward compatibility
  ];

  static const List<String> previousOrders = [
    completed,
    rejected,
    cancelled,
    failed,
  ];
}

