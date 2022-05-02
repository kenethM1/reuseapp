// ignore_for_file: unnecessary_this, unnecessary_getters_setters, file_names

class User {
  int? _id;
  String? _title;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _role;
  String? _created;
  String? _updated;
  bool? _isVerified;
  String? _jwtToken;
  String? _profilePicture;
  User(
      {int? id,
      String? title,
      String? firstName,
      String? lastName,
      String? email,
      String? role,
      String? created,
      String? updated,
      bool? isVerified,
      String? jwtToken,
      String? profilePicture}) {
    if (id != null) {
      this._id = id;
    }
    if (title != null) {
      this._title = title;
    }
    if (firstName != null) {
      this._firstName = firstName;
    }
    if (lastName != null) {
      this._lastName = lastName;
    }
    if (email != null) {
      this._email = email;
    }
    if (role != null) {
      this._role = role;
    }
    if (created != null) {
      this._created = created;
    }
    if (updated != null) {
      this._updated = updated;
    }
    if (isVerified != null) {
      this._isVerified = isVerified;
    }
    if (jwtToken != null) {
      this._jwtToken = jwtToken;
    }
    if (profilePicture != null) {
      this._profilePicture = profilePicture;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get firstName => _firstName;
  set firstName(String? firstName) => _firstName = firstName;
  String? get lastName => _lastName;
  set lastName(String? lastName) => _lastName = lastName;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get role => _role;
  set role(String? role) => _role = role;
  String? get created => _created;
  set created(String? created) => _created = created;
  String? get updated => _updated;
  set updated(String? updated) => _updated = updated;
  bool? get isVerified => _isVerified;
  set isVerified(bool? isVerified) => _isVerified = isVerified;
  String? get jwtToken => _jwtToken;
  set jwtToken(String? jwtToken) => _jwtToken = jwtToken;
  String? get profilePicture => _profilePicture;
  set profilePicture(String? profilePicture) =>
      _profilePicture = profilePicture;

  User.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _email = json['email'];
    _role = json['role'];
    _created = json['created'];
    _updated = json['updated'];
    _isVerified = json['isVerified'];
    _jwtToken = json['jwtToken'];
    _profilePicture = json['profilePicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this._id;
    data['title'] = this._title;
    data['firstName'] = this._firstName;
    data['lastName'] = this._lastName;
    data['email'] = this._email;
    data['role'] = this._role;
    data['created'] = this._created;
    data['updated'] = this._updated;
    data['isVerified'] = this._isVerified;
    data['jwtToken'] = this._jwtToken;
    data['profilePicture'] = this._profilePicture;
    return data;
  }
}
