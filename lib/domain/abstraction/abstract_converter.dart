abstract class AbstractConverter<T> {
  void fromJson(Map<String, dynamic> json);
  T entityFromJson(Map<String, dynamic> json);
  List fromJsonList(List jsonList);
  Map<String, dynamic> toJson();
}
