import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/data_source/generic_data_source.dart';
import 'package:raw_chem/common/http/either.dart';
import 'package:raw_chem/common/http/failure.dart';
import 'package:raw_chem/features/onboarding/model/welcome_screen_model.dart';

class OnboardingRepo {
  final GenericDataSource _dataSource;

  OnboardingRepo(this._dataSource);

  Future<Either<Failure, List<WelcomeScreenModel>>> getWelcomeScreens() async {
    return await _dataSource.fetchData<WelcomeScreenModel>(
      endpoint: EndPoints.welcomeScreens,
      fromJson: (json) => WelcomeScreenModel.fromJson(json),
    );
  }
}
