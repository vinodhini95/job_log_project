class Propertylist {
  Agent? agent;
  int? areaSqFt;
  int? bathrooms;
  int? bedrooms;
  String? currency;
  String? dateListed;
  String? description;
  String? id;
  List<String>? images;
  Location? location;
  int? price;
  String? status;
  List<String>? tags;
  String? title;

  Propertylist(
      {this.agent,
      this.areaSqFt,
      this.bathrooms,
      this.bedrooms,
      this.currency,
      this.dateListed,
      this.description,
      this.id,
      this.images,
      this.location,
      this.price,
      this.status,
      this.tags,
      this.title});

  Propertylist.fromJson(Map<String, dynamic> json) {
    agent = json['agent'] != null ? Agent.fromJson(json['agent']) : null;
    areaSqFt = json['areaSqFt'];
    bathrooms = json['bathrooms'];
    bedrooms = json['bedrooms'];
    currency = json['currency'];
    dateListed = json['dateListed'];
    description = json['description'];
    id = json['id'];
    images = json['images'].cast<String>();
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    price = json['price'];
    status = json['status'];
    tags = json['tags'].cast<String>();
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (agent != null) {
      data['agent'] = agent!.toJson();
    }
    data['areaSqFt'] = areaSqFt;
    data['bathrooms'] = bathrooms;
    data['bedrooms'] = bedrooms;
    data['currency'] = currency;
    data['dateListed'] = dateListed;
    data['description'] = description;
    data['id'] = id;
    data['images'] = images;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['price'] = price;
    data['status'] = status;
    data['tags'] = tags;
    data['title'] = title;
    return data;
  }
}

class Agent {
  String? contact;
  String? email;
  String? name;

  Agent({this.contact, this.email, this.name});

  Agent.fromJson(Map<String, dynamic> json) {
    contact = json['contact'];
    email = json['email'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contact'] = contact;
    data['email'] = email;
    data['name'] = name;
    return data;
  }
}

class Location {
  String? address;
  String? city;
  String? country;
  double? latitude;
  double? longitude;
  String? state;
  String? zip;

  Location(
      {this.address,
      this.city,
      this.country,
      this.latitude,
      this.longitude,
      this.state,
      this.zip});

  Location.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    city = json['city'];
    country = json['country'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    state = json['state'];
    zip = json['zip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['city'] = city;
    data['country'] = country;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['state'] = state;
    data['zip'] = zip;
    return data;
  }
}