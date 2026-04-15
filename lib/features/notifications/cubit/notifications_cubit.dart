import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raw_chem/common/http/pagination_helper.dart';
import 'package:raw_chem/core/state/base_state.dart';
import 'package:raw_chem/features/notifications/model/notification_model.dart';
import 'package:raw_chem/features/notifications/repo/notifications_repo.dart';

class NotificationsCubit extends Cubit<BaseState<NotificationModel>> {
  final NotificationsRepo _notificationsRepo;
  late final PaginationHandler<NotificationModel, NotificationsCubit> paginationHandler;

  NotificationsCubit(this._notificationsRepo) : super(const BaseState<NotificationModel>()) {
    paginationHandler = PaginationHandler<NotificationModel, NotificationsCubit>(
      bloc: this,
    );
  }

  Future<void> fetchNotifications({bool isReload = false}) async {
    if (isReload) {
      emit(state.copyWith(status: Status.loading, items: []));
    }

    await paginationHandler.loadFirstPage(
      (page, limit, [params]) => _notificationsRepo.getNotifications(page: page),
    );
  }

  Future<void> loadMoreNotifications() async {
    await paginationHandler.fetchData(
      (page, limit, [params]) => _notificationsRepo.getNotifications(page: page),
    );
  }
}
