import 'package:cf_app/screens/singleUserScreenModels/ratingChanges.dart'
    as rat;

//line chart spots data{x,y}
class Data {
  final double name1;
  final double value1;
  Data(this.name1, this.value1);
}

//spots list for line chart from rating change obj list
List<Data> ratingTimeline2users(List<rat.Result> ratingData) {
  List<Data> data = [];
  ratingData.forEach((r) {
    data.add(new Data(r.ratingUpdateTimeSeconds * 1.0, r.newRating.toDouble()));
  });
  return data;
}
