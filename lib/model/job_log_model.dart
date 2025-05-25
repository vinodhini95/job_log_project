class JobLogmodel {
  String? id;
  String? postcode;
  String? machineId;
  String? startAt;
  String? endAt;
  String? status;

  JobLogmodel(
      {this.id,
      this.endAt,
      this.machineId,
      this.startAt,
      this.postcode,
      this.status});
  JobLogmodel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    postcode = json['postcode'] ?? "";
    machineId = json['machine_id'] ?? "";
    startAt = json['start_at'] ?? "";
    endAt = json['end_at'] ?? "";
    status = json['status'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['postcode'] = postcode;
    data['machine_id'] = machineId;
    data['start_at'] = startAt;
    data['end_at'] = endAt;
    data['status'] = status;
    return data;
  }
}
