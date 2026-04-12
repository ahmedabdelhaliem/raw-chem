import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raw_chem/features/raw_materials/model/location_models.dart';
import 'package:raw_chem/features/raw_materials/repo/locations_repo.dart';

class LocationsState extends Equatable {
  final List<CountryModel> countries;
  final List<GovernorateModel> governorates;
  final List<CityModel> cities;

  final CountryModel? selectedCountry;
  final GovernorateModel? selectedGovernorate;
  final CityModel? selectedCity;

  final bool isLoadingCountries;
  final bool isLoadingGovernorates;
  final bool isLoadingCities;

  const LocationsState({
    this.countries = const [],
    this.governorates = const [],
    this.cities = const [],
    this.selectedCountry,
    this.selectedGovernorate,
    this.selectedCity,
    this.isLoadingCountries = false,
    this.isLoadingGovernorates = false,
    this.isLoadingCities = false,
  });

  LocationsState copyWith({
    List<CountryModel>? countries,
    List<GovernorateModel>? governorates,
    List<CityModel>? cities,
    CountryModel? selectedCountry,
    GovernorateModel? selectedGovernorate,
    CityModel? selectedCity,
    bool? isLoadingCountries,
    bool? isLoadingGovernorates,
    bool? isLoadingCities,
    bool resetGovernorates = false,
    bool resetCities = false,
    bool nullSelectedCountry = false,
    bool nullSelectedGovernorate = false,
    bool nullSelectedCity = false,
  }) {
    return LocationsState(
      countries: countries ?? this.countries,
      governorates: resetGovernorates ? [] : (governorates ?? this.governorates),
      cities: resetCities ? [] : (cities ?? this.cities),
      selectedCountry: nullSelectedCountry ? null : (selectedCountry ?? this.selectedCountry),
      selectedGovernorate: nullSelectedGovernorate ? null : (selectedGovernorate ?? this.selectedGovernorate),
      selectedCity: nullSelectedCity ? null : (selectedCity ?? this.selectedCity),
      isLoadingCountries: isLoadingCountries ?? this.isLoadingCountries,
      isLoadingGovernorates: isLoadingGovernorates ?? this.isLoadingGovernorates,
      isLoadingCities: isLoadingCities ?? this.isLoadingCities,
    );
  }

  @override
  List<Object?> get props => [
        countries,
        governorates,
        cities,
        selectedCountry,
        selectedGovernorate,
        selectedCity,
        isLoadingCountries,
        isLoadingGovernorates,
        isLoadingCities,
      ];
}

class LocationsCubit extends Cubit<LocationsState> {
  final LocationsRepo _repo;

  LocationsCubit(this._repo) : super(const LocationsState());

  Future<void> getCountries() async {
    emit(state.copyWith(isLoadingCountries: true));
    final result = await _repo.getCountries();
    result.fold(
      (failure) => emit(state.copyWith(isLoadingCountries: false)),
      (countries) => emit(state.copyWith(countries: countries, isLoadingCountries: false)),
    );
  }

  Future<void> selectCountry(CountryModel? country) async {
    if (country == state.selectedCountry) return;
    
    emit(state.copyWith(
      selectedCountry: country,
      resetGovernorates: true,
      resetCities: true,
      nullSelectedGovernorate: true,
      nullSelectedCity: true,
    ));

    if (country != null) {
      await getGovernorates(country.id);
    }
  }

  Future<void> getGovernorates(int countryId) async {
    emit(state.copyWith(isLoadingGovernorates: true));
    final result = await _repo.getGovernorates(countryId);
    result.fold(
      (failure) => emit(state.copyWith(isLoadingGovernorates: false)),
      (governorates) => emit(state.copyWith(governorates: governorates, isLoadingGovernorates: false)),
    );
  }

  Future<void> selectGovernorate(GovernorateModel? governorate) async {
    if (governorate == state.selectedGovernorate) return;

    emit(state.copyWith(
      selectedGovernorate: governorate,
      resetCities: true,
      nullSelectedCity: true,
    ));

    if (governorate != null) {
      await getCities(governorate.id);
    }
  }

  Future<void> getCities(int governorateId) async {
    emit(state.copyWith(isLoadingCities: true));
    final result = await _repo.getCities(governorateId);
    result.fold(
      (failure) => emit(state.copyWith(isLoadingCities: false)),
      (cities) => emit(state.copyWith(cities: cities, isLoadingCities: false)),
    );
  }

  void selectCity(CityModel? city) {
    emit(state.copyWith(selectedCity: city));
  }
}
