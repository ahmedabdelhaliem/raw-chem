import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/http/pagination_helper.dart';

class PurchaseOrdersHistoryCubit extends Cubit<BaseState<PurchaseOrderModel>> {
  final RawMaterialsRepo _repo;
  late final PaginationHandler<PurchaseOrderModel, PurchaseOrdersHistoryCubit> paginationHandler;
  dynamic _currentStatus;

  PurchaseOrdersHistoryCubit(this._repo) : super(const BaseState<PurchaseOrderModel>()) {
    paginationHandler = PaginationHandler<PurchaseOrderModel, PurchaseOrdersHistoryCubit>(
      bloc: this,
      pageSize: 10,
    );
  }

  Future<void> getPurchaseOrders({required dynamic status}) async {
    _currentStatus = status;
    await paginationHandler.loadFirstPage((page, limit, [params]) => 
      _repo.getPurchaseOrders(page: page, status: _currentStatus));
  }

  Future<void> loadMore() async {
    await paginationHandler.fetchData((page, limit, [params]) => 
      _repo.getPurchaseOrders(page: page, status: _currentStatus));
  }
}
