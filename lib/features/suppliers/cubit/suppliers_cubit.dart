import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raw_chem/core/state/base_state.dart';
import 'package:raw_chem/common/http/pagination_helper.dart';
import 'package:raw_chem/features/suppliers/model/supplier_model.dart';
import 'package:raw_chem/features/suppliers/repo/suppliers_repo.dart';

class SuppliersCubit extends Cubit<BaseState<SupplierModel>> {
  final SuppliersRepo _suppliersRepo;
  late final PaginationHandler<SupplierModel, SuppliersCubit> paginationHandler;
  String searchQuery = '';

  SuppliersCubit(this._suppliersRepo) : super(const BaseState<SupplierModel>()) {
    paginationHandler = PaginationHandler<SupplierModel, SuppliersCubit>(
      bloc: this,
      pageSize: 10,
    );
  }

  Future<void> fetchSuppliers({String? query}) async {
    if (query != null) {
      searchQuery = query;
    }
    await paginationHandler.loadFirstPage((page, limit, [params]) => 
      _suppliersRepo.getSuppliers(page: page, q: searchQuery));
  }

  Future<void> loadMore() async {
    await paginationHandler.fetchData((page, limit, [params]) => 
      _suppliersRepo.getSuppliers(page: page, q: searchQuery));
  }
}
