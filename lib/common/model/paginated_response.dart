import 'pagination_model.dart';

class PaginatedResponse<T> {
  final List<T> data;
  final PaginationModel pagination;

  PaginatedResponse({
    required this.data,
    required this.pagination,
  });
}
