import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raw_chem/core/state/base_state.dart';
import 'package:raw_chem/features/home/model/banner_model.dart';
import 'package:raw_chem/features/home/repo/home_repo.dart';

class BannersCubit extends Cubit<BaseState<BannerModel>> {
  final HomeRepo _homeRepo;

  BannersCubit(this._homeRepo) : super(const BaseState<BannerModel>());

  Future<void> fetchBanners() async {
    emit(state.copyWith(status: Status.loading));
    final result = await _homeRepo.getBanners();
    result.fold(
      (failure) => emit(state.copyWith(status: Status.error, failure: failure)),
      (banners) => emit(state.copyWith(status: Status.success, items: banners)),
    );
  }
}
