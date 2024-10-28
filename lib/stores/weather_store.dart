import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/services/api_key.dart';
part 'weather_store.g.dart';

class WeatherStore = _WeatherStoreBase with _$WeatherStore;

abstract class _WeatherStoreBase with Store {
  @observable
  Weather? _weather;

  @observable
  bool _isLoading = false;

  @observable
  String? _errorMessage;

  @computed
  Weather? get weather => _weather;

  @computed
  bool get isLoading => _isLoading;

  @computed
  String? get errorMessage => _errorMessage;

  @action
  Future<void> fetchWeather(Position position) async {
    _isLoading = true;
    _errorMessage = null;
    try {
      WeatherFactory wf = WeatherFactory(API_KEY, language: Language.ENGLISH);
      _weather = await wf.currentWeatherByLocation(position.latitude, position.longitude);
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
    }
  }
}
