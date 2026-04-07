import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raw_chem/core/state/base_state.dart';
import 'package:raw_chem/common/http/pagination_helper.dart';
import 'package:raw_chem/features/price_tracker/model/price_tracker_model.dart';
import 'package:raw_chem/features/suppliers/repo/suppliers_repo.dart';

class SuppliersMaterialsCubit extends Cubit<BaseState<PriceTrackerModel>> {
  final SuppliersRepo _suppliersRepo;
  late final PaginationHandler<PriceTrackerModel, SuppliersMaterialsCubit> paginationHandler;

  SuppliersMaterialsCubit(this._suppliersRepo) : super(const BaseState<PriceTrackerModel>()) {
    paginationHandler = PaginationHandler<PriceTrackerModel, SuppliersMaterialsCubit>(
      bloc: this,
      pageSize: 10,
    );
  }

  Future<void> fetchMaterials(int supplierId) async {
    await paginationHandler.loadFirstPage(
      (page, limit, [params]) => _suppliersRepo.getSupplierMaterials(
        supplierId: supplierId,
        page: page,
      ),
    );
  }
}
