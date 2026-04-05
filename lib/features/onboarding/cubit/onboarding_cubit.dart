import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raw_chem/core/state/base_state.dart';
import 'package:raw_chem/features/onboarding/model/welcome_screen_model.dart';
import 'package:raw_chem/features/onboarding/repo/onboarding_repo.dart';

class OnboardingCubit extends Cubit<BaseState<WelcomeScreenModel>> {
  final OnboardingRepo _onboardingRepo;

  OnboardingCubit(this._onboardingRepo) : super(const BaseState<WelcomeScreenModel>());

  Future<void> fetchWelcomeScreens() async {
    emit(state.copyWith(status: Status.loading));
    final result = await _onboardingRepo.getWelcomeScreens();
    result.fold(
      (failure) => emit(state.copyWith(status: Status.error, failure: failure)),
      (screens) {
        // Sort by order
        screens.sort((a, b) {
          final orderA = int.tryParse(a.order ?? '0') ?? 0;
          final orderB = int.tryParse(b.order ?? '0') ?? 0;
          return orderA.compareTo(orderB);
        });
        emit(state.copyWith(status: Status.success, items: screens));
      },
    );
  }
}
