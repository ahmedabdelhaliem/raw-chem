import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raw_chem/core/state/base_state.dart';
import 'package:raw_chem/common/http/pagination_helper.dart';
import 'package:raw_chem/features/price_tracker/model/price_tracker_model.dart';
import 'package:raw_chem/features/price_tracker/repo/price_tracker_repo.dart';

class PriceTrackerCubit extends Cubit<BaseState<PriceTrackerModel>> {
  final PriceTrackerRepo _priceTrackerRepo;
  late final PaginationHandler<PriceTrackerModel, PriceTrackerCubit> paginationHandler;

  PriceTrackerCubit(this._priceTrackerRepo) : super(const BaseState<PriceTrackerModel>()) {
    paginationHandler = PaginationHandler<PriceTrackerModel, PriceTrackerCubit>(
      bloc: this,
      pageSize: 10,
    );
  }

  Future<void> fetchSupplierMaterials() async {
    await paginationHandler.loadFirstPage((page, limit, [params]) => _priceTrackerRepo.getSupplierMaterials(page: page));
  }
}
