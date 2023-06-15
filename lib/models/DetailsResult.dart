
class DetailsResult {
  int? id;
  String? title;
  MainPicture? mainPicture;
  String? startDate;
  String? endDate;
  String? synopsis;

  DetailsResult(
      {this.id,
      this.title,
      this.mainPicture,
      this.startDate,
      this.endDate,
      this.synopsis});

  DetailsResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    mainPicture = json['main_picture'] != null
        ? new MainPicture.fromJson(json['main_picture'])
        : null;
    startDate = json['start_date'];
    endDate = json['end_date'];
    synopsis = json['synopsis'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.mainPicture != null) {
      data['main_picture'] = this.mainPicture!.toJson();
    }
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['synopsis'] = this.synopsis;
    return data;
  }
}

class MainPicture {
  String? medium;
  String? large;

  MainPicture({this.medium, this.large});

  MainPicture.fromJson(Map<String, dynamic> json) {
    medium = json['medium'];
    large = json['large'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['medium'] = this.medium;
    data['large'] = this.large;
    return data;
  }
}