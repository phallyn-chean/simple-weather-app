// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$WeatherStore on _WeatherStoreBase, Store {
  Computed<Weather?>? _$weatherComputed;

  @override
  Weather? get weather =>
      (_$weatherComputed ??= Computed<Weather?>(() => super.weather,
              name: '_WeatherStoreBase.weather'))
          .value;
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_WeatherStoreBase.isLoading'))
          .value;
  Computed<String?>? _$errorMessageComputed;

  @override
  String? get errorMessage =>
      (_$errorMessageComputed ??= Computed<String?>(() => super.errorMessage,
              name: '_WeatherStoreBase.errorMessage'))
          .value;

  late final _$_weatherAtom =
      Atom(name: '_WeatherStoreBase._weather', context: context);

  @override
  Weather? get _weather {
    _$_weatherAtom.reportRead();
    return super._weather;
  }

  @override
  set _weather(Weather? value) {
    _$_weatherAtom.reportWrite(value, super._weather, () {
      super._weather = value;
    });
  }

  late final _$_isLoadingAtom =
      Atom(name: '_WeatherStoreBase._isLoading', context: context);

  @override
  bool get _isLoading {
    _$_isLoadingAtom.reportRead();
    return super._isLoading;
  }

  @override
  set _isLoading(bool value) {
    _$_isLoadingAtom.reportWrite(value, super._isLoading, () {
      super._isLoading = value;
    });
  }

  late final _$_errorMessageAtom =
      Atom(name: '_WeatherStoreBase._errorMessage', context: context);

  @override
  String? get _errorMessage {
    _$_errorMessageAtom.reportRead();
    return super._errorMessage;
  }

  @override
  set _errorMessage(String? value) {
    _$_errorMessageAtom.reportWrite(value, super._errorMessage, () {
      super._errorMessage = value;
    });
  }

  late final _$fetchWeatherAsyncAction =
      AsyncAction('_WeatherStoreBase.fetchWeather', context: context);

  @override
  Future<void> fetchWeather(Position position) {
    return _$fetchWeatherAsyncAction.run(() => super.fetchWeather(position));
  }

  @override
  String toString() {
    return '''
weather: ${weather},
isLoading: ${isLoading},
errorMessage: ${errorMessage}
    ''';
  }
}
