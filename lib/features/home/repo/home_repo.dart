import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/data_source/generic_data_source.dart';
import 'package:raw_chem/common/http/either.dart';
import 'package:raw_chem/common/http/failure.dart';
import 'package:raw_chem/features/home/model/banner_model.dart';

class HomeRepo {
  final GenericDataSource _dataSource;

  HomeRepo(this._dataSource);

  Future<Either<Failure, List<BannerModel>>> getBanners() async {
    return await _dataSource.fetchData<BannerModel>(
      endpoint: EndPoints.banners,
      fromJson: (json) => BannerModel.fromJson(json),
    );
  }
}
