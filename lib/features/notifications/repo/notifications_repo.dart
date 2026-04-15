import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/data_source/generic_data_source.dart';
import 'package:raw_chem/common/http/either.dart';
import 'package:raw_chem/common/http/failure.dart';
import 'package:raw_chem/common/http/params.dart';
import 'package:raw_chem/common/model/paginated_response.dart';
import 'package:raw_chem/features/notifications/model/notification_model.dart';

class NotificationsRepo {
  final GenericDataSource _dataSource;

  NotificationsRepo(this._dataSource);

  Future<Either<Failure, PaginatedResponse<NotificationModel>>> getNotifications({
    int page = 1,
  }) async {
    return await _dataSource.fetchPaginatedData<NotificationModel>(
      endpoint: EndPoints.notifications,
      params: PaginationParams(
        page: page,
        limit: 15,
      ),
      fromJson: (json) => NotificationModel.fromJson(json),
    );
  }
}
