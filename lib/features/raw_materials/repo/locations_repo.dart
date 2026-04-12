import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/data_source/generic_data_source.dart';
import 'package:raw_chem/common/http/either.dart';
import 'package:raw_chem/common/http/failure.dart';
import 'package:raw_chem/features/raw_materials/model/location_models.dart';

class LocationsRepo {
  final GenericDataSource _dataSource;

  LocationsRepo(this._dataSource);

  Future<Either<Failure, List<CountryModel>>> getCountries() async {
    return await _dataSource.fetchData<CountryModel>(
      endpoint: EndPoints.countries,
      fromJson: (json) => CountryModel.fromJson(json),
    );
  }

  Future<Either<Failure, List<GovernorateModel>>> getGovernorates(int countryId) async {
    return await _dataSource.fetchData<GovernorateModel>(
      endpoint: EndPoints.governorates(countryId),
      fromJson: (json) => GovernorateModel.fromJson(json),
    );
  }

  Future<Either<Failure, List<CityModel>>> getCities(int governorateId) async {
    return await _dataSource.fetchData<CityModel>(
      endpoint: EndPoints.cities(governorateId),
      fromJson: (json) => CityModel.fromJson(json),
    );
  }
}
