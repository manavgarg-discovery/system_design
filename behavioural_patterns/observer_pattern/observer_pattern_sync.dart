// Observer Pattern Implementation in Dart (Synchronous)
// It uses push model where the subject (Observable) pushes the updated data to the observers.

abstract class Observer {
  void update<T>(T data);
}

mixin Observable {
  final List<Observer> _observers = [];

  void addObserver(Observer observer) {
    _observers.add(observer);
  }

  void removeObserver(Observer observer) {
    _observers.remove(observer);
  }

  void notifyObservers<T>(T data) {
    for (final observer in _observers) {
      observer.update(data);
    }
  }
}

class WeatherStation with Observable {
  double _temperature = 0.0;

  double get temperature => _temperature;

  void setTemperature(double temperature) {
    _temperature = temperature;
    notifyObservers<double>(temperature);
  }
}

class WeatherDisplay implements Observer {
  final String name;

  WeatherDisplay(this.name);

  void addObserver(Observable station) {
    station.addObserver(this);
  }

  @override
  void update<double>(double data) {
    print('[$name] Current temperature: ${data}°C');
  }
}

void main() {
  final weatherStation = WeatherStation();
  final weatherDisplay1 = WeatherDisplay('Display 1');
  final weatherDisplay2 = WeatherDisplay('Display 2');

  weatherDisplay1.addObserver(weatherStation);
  weatherDisplay2.addObserver(weatherStation);

  weatherStation.setTemperature(25.0);
  weatherStation.removeObserver(weatherDisplay1);
  weatherStation.setTemperature(30.0);
}
