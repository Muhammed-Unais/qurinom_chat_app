class AuthResponse {
  final String token;
  final User user;

  AuthResponse({required this.token, required this.user});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'] as String,
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'token': token, 'user': user.toJson()};
  }
}

class User {
  final String id;
  final String? name;
  final String? email;
  final String? gender;
  final String? phone;
  final String? addressLane1;
  final String? addressLane2;
  final String? city;
  final String? state;
  final String? postalCode;
  final String? country;
  final bool? isOnline;
  final List<String>? blockedUsers;
  final String? role;
  final bool? isVerified;
  final bool? isDeleted;
  final String? deletedMessage;
  final bool? isDisabled;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final DateTime? lastSeen;
  final String? profile;
  final DateTime? deletedTime;
  final String? plan;
  final String? previousPlan;
  final DateTime? createdForTTL;
  final List<PaymentHistory>? paymentHistory;
  final String? referralCode;
  final DateTime? planEndDate;
  final List<String>? fcmTokens;
  final Location? location;

  User({
    required this.id,
    this.name,
    this.email,
    this.gender,
    this.phone,
    this.addressLane1,
    this.addressLane2,
    this.city,
    this.state,
    this.postalCode,
    this.country,
    this.isOnline,
    this.blockedUsers,
    this.role,
    this.isVerified,
    this.isDeleted,
    this.deletedMessage,
    this.isDisabled,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.lastSeen,
    this.profile,
    this.deletedTime,
    this.plan,
    this.previousPlan,
    this.createdForTTL,
    this.paymentHistory,
    this.referralCode,
    this.planEndDate,
    this.fcmTokens,
    this.location,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String,
      name: json['name'] as String?,
      email: json['email'] as String?,
      gender: json['gender'] as String?,
      phone: json['phone'] as String?,
      addressLane1: json['addressLane1'] as String?,
      addressLane2: json['addressLane2'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      postalCode: json['postalCode'] as String?,
      country: json['country'] as String?,
      isOnline: json['isOnline'] as bool?,
      blockedUsers:
          (json['blockedUsers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      role: json['role'] as String?,
      isVerified: json['isVerified'] as bool?,
      isDeleted: json['isDeleted'] as bool?,
      deletedMessage: json['deletedMessage'] as String?,
      isDisabled: json['isDisabled'] as bool?,
      createdAt:
          json['createdAt'] != null
              ? DateTime.tryParse(json['createdAt'])
              : null,
      updatedAt:
          json['updatedAt'] != null
              ? DateTime.tryParse(json['updatedAt'])
              : null,
      v: json['__v'] as int?,
      lastSeen:
          json['lastSeen'] != null ? DateTime.tryParse(json['lastSeen']) : null,
      profile: json['profile'] as String?,
      deletedTime:
          json['deletedTime'] != null
              ? DateTime.tryParse(json['deletedTime'])
              : null,
      plan: json['plan'] as String?,
      previousPlan: json['previousPlan'] as String?,
      createdForTTL:
          json['createdForTTL'] != null
              ? DateTime.tryParse(json['createdForTTL'])
              : null,
      paymentHistory:
          (json['paymentHistory'] as List<dynamic>?)
              ?.map((e) => PaymentHistory.fromJson(e))
              .toList(),
      referralCode: json['referralCode'] as String?,
      planEndDate:
          json['planEndDate'] != null
              ? DateTime.tryParse(json['planEndDate'])
              : null,
      fcmTokens:
          (json['fcmTokens'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      location:
          json['location'] != null ? Location.fromJson(json['location']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'gender': gender,
      'phone': phone,
      'addressLane1': addressLane1,
      'addressLane2': addressLane2,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
      'isOnline': isOnline,
      'blockedUsers': blockedUsers,
      'role': role,
      'isVerified': isVerified,
      'isDeleted': isDeleted,
      'deletedMessage': deletedMessage,
      'isDisabled': isDisabled,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': v,
      'lastSeen': lastSeen?.toIso8601String(),
      'profile': profile,
      'deletedTime': deletedTime?.toIso8601String(),
      'plan': plan,
      'previousPlan': previousPlan,
      'createdForTTL': createdForTTL?.toIso8601String(),
      'paymentHistory': paymentHistory?.map((e) => e.toJson()).toList(),
      'referralCode': referralCode,
      'planEndDate': planEndDate?.toIso8601String(),
      'fcmTokens': fcmTokens,
      'location': location?.toJson(),
    };
  }
}

class PaymentHistory {
  final String? orderId;
  final int? amount;
  final String? currency;
  final String? status;
  final PaymentMethod? method;
  final DateTime? paidAt;
  final String? id;

  PaymentHistory({
    this.orderId,
    this.amount,
    this.currency,
    this.status,
    this.method,
    this.paidAt,
    this.id,
  });

  factory PaymentHistory.fromJson(Map<String, dynamic> json) {
    return PaymentHistory(
      orderId: json['orderId'] as String?,
      amount: json['amount'] as int?,
      currency: json['currency'] as String?,
      status: json['status'] as String?,
      method:
          json['method'] != null
              ? PaymentMethod.fromJson(json['method'])
              : null,
      paidAt: json['paidAt'] != null ? DateTime.tryParse(json['paidAt']) : null,
      id: json['_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'amount': amount,
      'currency': currency,
      'status': status,
      'method': method?.toJson(),
      'paidAt': paidAt?.toIso8601String(),
      '_id': id,
    };
  }
}

class PaymentMethod {
  final Upi? upi;

  PaymentMethod({this.upi});

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      upi: json['upi'] != null ? Upi.fromJson(json['upi']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'upi': upi?.toJson()};
  }
}

class Upi {
  final String? channel;
  final String? upiId;

  Upi({this.channel, this.upiId});

  factory Upi.fromJson(Map<String, dynamic> json) {
    return Upi(
      channel: json['channel'] as String?,
      upiId: json['upi_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'channel': channel, 'upi_id': upiId};
  }
}

class Location {
  final double? latitude;
  final double? longitude;

  Location({this.latitude, this.longitude});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'latitude': latitude, 'longitude': longitude};
  }
}
