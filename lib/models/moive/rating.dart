class Rating {
  String? source;
  String? value;

  Rating({
    required this.source,
    required this.value,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        source: json["Source"],
        value: json["Value"],
      );

  Map<String, dynamic> toJson() => {
        "Source": source,
        "Value": value,
      };
}
