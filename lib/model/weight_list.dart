// @dart=2.9
class WeightDetail {
  final String wid;
  final double weight;

  WeightDetail({this.wid, this.weight});

  factory WeightDetail.fromJson(Map<String, dynamic> json) {
    return WeightDetail(
      wid: json['wid'],
      weight: json['weight'],
    );
  }
}
