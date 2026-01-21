enum FlavorType { free, premium }

class FlavorValues {
  final String labelApp;

  const FlavorValues({this.labelApp = "Free"});
}

class FlavorConfig {
  final FlavorType flavor;
  final FlavorValues values;

  static FlavorConfig? _instance;

  FlavorConfig({
    this.flavor = FlavorType.free,
    this.values = const FlavorValues(),
  }) {
    _instance = this;
  }

  static FlavorConfig get instance => _instance ?? FlavorConfig();
}
