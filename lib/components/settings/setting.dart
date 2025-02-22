
abstract class Setting<T> {
  void setValue(T newValue);
  T getValue();

  String keyOf(String name) {
    return "setting-$name";
  }
}