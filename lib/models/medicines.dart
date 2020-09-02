import 'package:json_annotation/json_annotation.dart';

part 'medicines.g.dart';

@JsonSerializable()
class Medicine {
  @JsonKey(name: '_id')
  final String mongoId;
  final int id;
  @JsonKey(name: 'drugName')
  final String drugName;
  final String composition;
  final String manufacturer;
  final double price;
  final String packing;
  final String prescription;
  final String introduction;
  @JsonKey(name: 'useOfMedicine')
  final String useOfMedicine;
  @JsonKey(name: 'sideEffects')
  final String sideEffects;
  @JsonKey(name: 'howToCope')
  final String howToCope;
  @JsonKey(name: 'howToUse')
  final String howToUse;
  @JsonKey(name: 'howItWork')
  final String howItWork;
  @JsonKey(name: 'safetyAdvice')
  final String safetyAdvice;
  @JsonKey(name: 'ifForget')
  final String ifForget;
  @JsonKey(name: 'expertAdvice')
  final String expertAdvice;
  @JsonKey(name: 'alternateBrand')
  final String alternateBrand;
  @JsonKey(name: 'interactionWithDrug')
  final String interactionWithDrug;
  @JsonKey(name: 'patentConcerns')
  final String patentConcerns;
  @JsonKey(name: 'relatedProduct')
  final String relatedProduct;
  @JsonKey(name: 'feedBacks')
  final String feedBacks;
  @JsonKey(name: 'ayurvedicIngredients')
  final String ayurvedicIngredients;
  @JsonKey(name: 'relatedLabTest')
  final String relatedLabTest;
  final String faq;
  final String references;
  @JsonKey(name: 'manufactureAddress')
  final String manufactureAddress;
  @JsonKey(name: 'vendorPartner')
  final String vendorPartner;

  Medicine({
    this.mongoId,
    this.id,
    this.drugName,
    this.composition,
    this.manufacturer,
    this.price,
    this.packing,
    this.prescription,
    this.introduction,
    this.useOfMedicine,
    this.sideEffects,
    this.howToCope,
    this.howToUse,
    this.howItWork,
    this.safetyAdvice,
    this.ifForget,
    this.expertAdvice,
    this.alternateBrand,
    this.interactionWithDrug,
    this.patentConcerns,
    this.relatedProduct,
    this.feedBacks,
    this.ayurvedicIngredients,
    this.relatedLabTest,
    this.faq,
    this.references,
    this.manufactureAddress,
    this.vendorPartner,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) =>
      _$MedicineFromJson(json);
  Map<String, dynamic> toJson() => _$MedicineToJson(this);
}
