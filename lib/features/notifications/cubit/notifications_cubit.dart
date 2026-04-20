import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raw_chem/app/app_prefs.dart';
import 'package:raw_chem/common/http/pagination_helper.dart';
import 'package:raw_chem/core/state/base_state.dart';
import 'package:raw_chem/features/notifications/model/notification_model.dart';
import 'package:raw_chem/features/notifications/repo/notifications_repo.dart';

class NotificationsCubit extends Cubit<BaseState<NotificationModel>> {
  final NotificationsRepo _notificationsRepo;
  final AppPreferences _appPreferences;
  late final PaginationHandler<NotificationModel, NotificationsCubit> paginationHandler;

  /// IDs of notifications already read — persisted across sessions
  late final Set<int> readIds;

  NotificationsCubit(this._notificationsRepo, this._appPreferences)
      : super(const BaseState<NotificationModel>()) {
    readIds = _appPreferences.getReadNotificationIds();
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

  /// Mark as read and save persistently
  void markAsRead(int notificationId) {
    if (!readIds.contains(notificationId)) {
      readIds.add(notificationId);
      _appPreferences.saveReadNotificationIds(readIds);
      
      // Force re-emit by updating metadata so Equatable sees a difference
      final Map<String, dynamic> newMetadata = Map.from(state.metadata);
      newMetadata['refresh_trigger'] = DateTime.now().millisecondsSinceEpoch;
      
      emit(state.copyWith(metadata: newMetadata));
    }
  }
}
