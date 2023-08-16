// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AdcioSuggestionRawData {
  final List<AdcioSuggestion> suggestions;
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
  final Map<String, dynamic> logOptions;
  final Product? product;
  final Map<String, dynamic>? banner;

  AdcioSuggestion({required this.logOptions, this.product, this.banner});

  factory AdcioSuggestion.fromJson(Map<String, dynamic> json) {
    return AdcioSuggestion(
      logOptions: json['logOptions'],
      product: Product.fromMap(json['product']),
      banner: json['banner'],
    );
  }
}

class Product {
  final String id;
  final String code;
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
  final String? createdAt;
  final String? updatedAt;

  Product({
    required this.id,
    required this.code,
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
    String? code,
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
      code: code ?? this.code,
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
      'code': code,
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
      code: map['code'] as String,
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
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(id: $id, code: $code, storeId: $storeId, sellerId: $sellerId, name: $name, price: $price, description: $description, image: $image, includeInRecommendation: $includeInRecommendation, data: $data, url: $url, deepLink: $deepLink, caption: $caption, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.code == code &&
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
        code.hashCode ^
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
