// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

/// Fetch a personalized suggestion.
/// - placement: meta data of the placement
/// - suggestions: list of suggestions
///   (product or banner)
class AdcioSuggestionRawData {
  /// It returns personalized product or banner information.
  final List<AdcioSuggestion> suggestions;

  /// meta data of the placement
  final Map<String, dynamic> placement;

  AdcioSuggestionRawData({
    required this.suggestions,
    required this.placement,
  });

  factory AdcioSuggestionRawData.fromJson(Map<String, dynamic> json) {
    final suggestions = <AdcioSuggestion>[];

    final results = json['suggestions'] as List;
    for (final result in results) {
      final suggestion = AdcioSuggestion.fromJson(result);
      suggestions.add(suggestion);
    }

    return AdcioSuggestionRawData(
      suggestions: suggestions,
      placement: json['placement'],
    );
  }
}

class AdcioSuggestion {
  /// This is the log option information to be
  /// used in [adcio_analytics](https://pub.dev/packages/adcio_analytics)
  final Map<String, dynamic> logOptions;

  /// personalized product
  final Product? product;

  /// personalized banner
  final Banner? banner;

  AdcioSuggestion({required this.logOptions, this.product, this.banner});

  factory AdcioSuggestion.fromJson(Map<String, dynamic> json) {
    return AdcioSuggestion(
      logOptions: json['logOptions'],
      product:
          json['product'] != null ? Product.fromMap(json['product']) : null,
      banner: json['banner'] != null ? Banner.fromMap(json['banner']) : null,
    );
  }
}

class Product {
  final String id;
  final String idOnStore;
  final String storeId;
  final String sellerId;
  final String name;
  final int price;
  final String description;
  final String image;
  final bool includeInRecommendation;
  final Map? data;
  final String? url;
  final String? deepLink;
  final String? caption;
  final String createdAt;
  final String updatedAt;

  Product({
    required this.id,
    required this.idOnStore,
    required this.storeId,
    required this.sellerId,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.includeInRecommendation,
    required this.data,
    required this.url,
    required this.deepLink,
    required this.caption,
    required this.createdAt,
    required this.updatedAt,
  });

  Product copyWith({
    String? id,
    String? idOnStore,
    String? storeId,
    String? sellerId,
    String? name,
    int? price,
    String? description,
    String? image,
    bool? includeInRecommendation,
    Map? data,
    String? url,
    String? deepLink,
    String? caption,
    String? createdAt,
    String? updatedAt,
  }) {
    return Product(
      id: id ?? this.id,
      idOnStore: idOnStore ?? this.idOnStore,
      storeId: storeId ?? this.storeId,
      sellerId: sellerId ?? this.sellerId,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      image: image ?? this.image,
      includeInRecommendation:
          includeInRecommendation ?? this.includeInRecommendation,
      data: data ?? this.data,
      url: url ?? this.url,
      deepLink: deepLink ?? this.deepLink,
      caption: caption ?? this.caption,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idOnStore': idOnStore,
      'storeId': storeId,
      'sellerId': sellerId,
      'name': name,
      'price': price,
      'description': description,
      'image': image,
      'includeInRecommendation': includeInRecommendation,
      'data': data?.toString(),
      'url': url,
      'deepLink': deepLink,
      'caption': caption,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String,
      idOnStore: map['idOnStore'] as String,
      storeId: map['storeId'] as String,
      sellerId: map['sellerId'] as String,
      name: map['name'] as String,
      price: map['price'] as int,
      description: map['description'] as String,
      image: map['image'] as String,
      includeInRecommendation: map['includeInRecommendation'] as bool,
      data: map['data'] != null ? (map['data'] as Map<String, dynamic>) : null,
      url: map['url'] != null ? map['url'] as String : null,
      deepLink: map['deepLink'] != null ? map['deepLink'] as String : null,
      caption: map['caption'] != null ? map['caption'] as String : null,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(id: $id, idOnStore: $idOnStore, storeId: $storeId, sellerId: $sellerId, name: $name, price: $price, description: $description, image: $image, includeInRecommendation: $includeInRecommendation, data: $data, url: $url, deepLink: $deepLink, caption: $caption, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.idOnStore == idOnStore &&
        other.storeId == storeId &&
        other.sellerId == sellerId &&
        other.name == name &&
        other.price == price &&
        other.description == description &&
        other.image == image &&
        other.includeInRecommendation == includeInRecommendation &&
        other.data == data &&
        other.url == url &&
        other.deepLink == deepLink &&
        other.caption == caption &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        idOnStore.hashCode ^
        storeId.hashCode ^
        sellerId.hashCode ^
        name.hashCode ^
        price.hashCode ^
        description.hashCode ^
        image.hashCode ^
        includeInRecommendation.hashCode ^
        data.hashCode ^
        url.hashCode ^
        deepLink.hashCode ^
        caption.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}

class Banner {
  final String id;
  final String clientId;
  final String imageUrl;
  final String url;
  final Map? data;
  final bool activated;
  final String startsAt;
  final String? endsAt;
  final String createdAt;
  final String deletedAt;

  Banner({
    required this.id,
    required this.clientId,
    required this.imageUrl,
    required this.url,
    required this.data,
    required this.activated,
    required this.startsAt,
    required this.endsAt,
    required this.createdAt,
    required this.deletedAt,
  });

  Banner copyWith({
    String? id,
    String? clientId,
    String? imageUrl,
    String? url,
    Map? data,
    bool? activated,
    String? startsAt,
    String? endsAt,
    String? createdAt,
    String? deletedAt,
  }) {
    return Banner(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      imageUrl: imageUrl ?? this.imageUrl,
      url: url ?? this.url,
      data: data ?? this.data,
      activated: activated ?? this.activated,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'clientId': clientId,
      'imageUrl': imageUrl,
      'url': url,
      'data': data.toString(),
      'activated': activated,
      'startsAt': startsAt,
      'endsAt': endsAt,
      'createdAt': createdAt,
      'deletedAt': deletedAt,
    };
  }

  factory Banner.fromMap(Map<String, dynamic> map) {
    return Banner(
      id: map['id'] as String,
      clientId: map['clientId'] as String,
      imageUrl: map['imageUrl'] as String,
      url: map['url'] as String,
      data: map['data'] != null ? (map['data'] as Map<String, dynamic>) : null,
      activated: map['activated'] as bool,
      startsAt: map['startsAt'] as String,
      endsAt: map['endsAt'] != null ? map['endsAt'] as String : null,
      createdAt: map['createdAt'] as String,
      deletedAt: map['deletedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Banner.fromJson(String source) =>
      Banner.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Banner(id: $id, clientId: $clientId, imageUrl: $imageUrl, url: $url, data: $data, activated: $activated, startsAt: $startsAt, endsAt: $endsAt, createdAt: $createdAt, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(covariant Banner other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.clientId == clientId &&
        other.imageUrl == imageUrl &&
        other.url == url &&
        other.data == data &&
        other.activated == activated &&
        other.startsAt == startsAt &&
        other.endsAt == endsAt &&
        other.createdAt == createdAt &&
        other.deletedAt == deletedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        clientId.hashCode ^
        imageUrl.hashCode ^
        url.hashCode ^
        data.hashCode ^
        activated.hashCode ^
        startsAt.hashCode ^
        endsAt.hashCode ^
        createdAt.hashCode ^
        deletedAt.hashCode;
  }
}
