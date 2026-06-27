class HomeModel {
  const HomeModel({this.results, this.info});

  static HomeModel fromJson(final Map<String, dynamic> json) => HomeModel(
    results: json['results'] != null
        ? (json['results'] as List<dynamic>)
              .map((final e) => HomeResponse.fromJson(e as Map<String, dynamic>))
              .toList()
        : null,
    info: json['info'] != null ? Info.fromJson(json['info'] as Map<String, dynamic>) : null,
  );

  final List<HomeResponse>? results;
  final Info? info;

  Map<String, dynamic> toJson() => {
    'results': results?.map((e) => e.toJson()).toList(),
    'info': info?.toJson(),
  };
}

class HomeResponse {
  const HomeResponse({
    this.gender,
    this.name,
    this.location,
    this.email,
    this.login,
    this.dob,
    this.registered,
    this.phone,
    this.cell,
    this.id,
    this.picture,
    this.nat,
  });

  static HomeResponse fromJson(final Map<String, dynamic> json) => HomeResponse(
    gender: json['gender'] as String?,
    name: json['name'] != null ? Name.fromJson(json['name'] as Map<String, dynamic>) : null,
    location: json['location'] != null
        ? Location.fromJson(json['location'] as Map<String, dynamic>)
        : null,
    email: json['email'] as String?,
    login: json['login'] != null ? Login.fromJson(json['login'] as Map<String, dynamic>) : null,
    dob: json['dob'] != null ? Dob.fromJson(json['dob'] as Map<String, dynamic>) : null,
    registered: json['registered'] != null
        ? Dob.fromJson(json['registered'] as Map<String, dynamic>)
        : null,
    phone: json['phone'] as String?,
    cell: json['cell'] as String?,
    id: json['id'] != null ? Id.fromJson(json['id'] as Map<String, dynamic>) : null,
    picture: json['picture'] != null
        ? Picture.fromJson(json['picture'] as Map<String, dynamic>)
        : null,
    nat: json['nat'] as String?,
  );

  final String? gender;
  final Name? name;
  final Location? location;
  final String? email;
  final Login? login;
  final Dob? dob;
  final Dob? registered;
  final String? phone;
  final String? cell;
  final Id? id;
  final Picture? picture;
  final String? nat;

  Map<String, dynamic> toJson() => {
    'gender': gender,
    'name': name?.toJson(),
    'location': location?.toJson(),
    'email': email,
    'login': login?.toJson(),
    'dob': dob?.toJson(),
    'registered': registered?.toJson(),
    'phone': phone,
    'cell': cell,
    'id': id?.toJson(),
    'picture': picture?.toJson(),
    'nat': nat,
  };
}

class Name {
  const Name({this.title, this.first, this.last});

  static Name fromJson(final Map<String, dynamic> json) => Name(
    title: json['title'] as String?,
    first: json['first'] as String?,
    last: json['last'] as String?,
  );

  final String? title;
  final String? first;
  final String? last;

  Map<String, dynamic> toJson() => {'title': title, 'first': first, 'last': last};
}

class Location {
  const Location({
    this.street,
    this.city,
    this.state,
    this.country,
    this.postcode,
    this.coordinates,
    this.timezone,
  });

  static Location fromJson(final Map<String, dynamic> json) => Location(
    street: json['street'] != null ? Street.fromJson(json['street'] as Map<String, dynamic>) : null,
    city: json['city'] as String?,
    state: json['state'] as String?,
    country: json['country'] as String?,
    postcode: json['postcode']?.toString(),
    coordinates: json['coordinates'] != null
        ? Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>)
        : null,
    timezone: json['timezone'] != null
        ? Timezone.fromJson(json['timezone'] as Map<String, dynamic>)
        : null,
  );

  final Street? street;
  final String? city;
  final String? state;
  final String? country;
  final String? postcode;
  final Coordinates? coordinates;
  final Timezone? timezone;

  Map<String, dynamic> toJson() => {
    'street': street?.toJson(),
    'city': city,
    'state': state,
    'country': country,
    'postcode': postcode,
    'coordinates': coordinates?.toJson(),
    'timezone': timezone?.toJson(),
  };
}

class Street {
  const Street({this.number, this.name});

  static Street fromJson(final Map<String, dynamic> json) =>
      Street(number: json['number'] as int?, name: json['name'] as String?);

  final int? number;
  final String? name;

  Map<String, dynamic> toJson() => {'number': number, 'name': name};
}

class Coordinates {
  const Coordinates({this.latitude, this.longitude});

  static Coordinates fromJson(final Map<String, dynamic> json) =>
      Coordinates(latitude: json['latitude'] as String?, longitude: json['longitude'] as String?);

  final String? latitude;
  final String? longitude;

  Map<String, dynamic> toJson() => {'latitude': latitude, 'longitude': longitude};
}

class Timezone {
  const Timezone({this.offset, this.description});

  static Timezone fromJson(final Map<String, dynamic> json) =>
      Timezone(offset: json['offset'] as String?, description: json['description'] as String?);

  final String? offset;
  final String? description;

  Map<String, dynamic> toJson() => {'offset': offset, 'description': description};
}

class Login {
  const Login({
    this.uuid,
    this.username,
    this.password,
    this.salt,
    this.md5,
    this.sha1,
    this.sha256,
  });

  static Login fromJson(final Map<String, dynamic> json) => Login(
    uuid: json['uuid'] as String?,
    username: json['username'] as String?,
    password: json['password'] as String?,
    salt: json['salt'] as String?,
    md5: json['md5'] as String?,
    sha1: json['sha1'] as String?,
    sha256: json['sha256'] as String?,
  );

  final String? uuid;
  final String? username;
  final String? password;
  final String? salt;
  final String? md5;
  final String? sha1;
  final String? sha256;

  Map<String, dynamic> toJson() => {
    'uuid': uuid,
    'username': username,
    'password': password,
    'salt': salt,
    'md5': md5,
    'sha1': sha1,
    'sha256': sha256,
  };
}

class Dob {
  const Dob({this.date, this.age});

  static Dob fromJson(final Map<String, dynamic> json) =>
      Dob(date: json['date'] as String?, age: json['age'] as int?);

  final String? date;
  final int? age;

  Map<String, dynamic> toJson() => {'date': date, 'age': age};
}

class Id {
  const Id({this.name, this.value});

  static Id fromJson(final Map<String, dynamic> json) =>
      Id(name: json['name'] as String?, value: json['value']?.toString());

  final String? name;
  final String? value;

  Map<String, dynamic> toJson() => {'name': name, 'value': value};
}

class Picture {
  const Picture({this.large, this.medium, this.thumbnail});

  static Picture fromJson(final Map<String, dynamic> json) => Picture(
    large: json['large'] as String?,
    medium: json['medium'] as String?,
    thumbnail: json['thumbnail'] as String?,
  );

  final String? large;
  final String? medium;
  final String? thumbnail;

  Map<String, dynamic> toJson() => {'large': large, 'medium': medium, 'thumbnail': thumbnail};
}

class Info {
  const Info({this.seed, this.results, this.page, this.version});

  static Info fromJson(final Map<String, dynamic> json) => Info(
    seed: json['seed'] as String?,
    results: json['results'] as int?,
    page: json['page'] as int?,
    version: json['version'] as String?,
  );

  final String? seed;
  final int? results;
  final int? page;
  final String? version;

  Map<String, dynamic> toJson() => {
    'seed': seed,
    'results': results,
    'page': page,
    'version': version,
  };
}
