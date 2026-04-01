// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faq_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FaqResponseImpl _$$FaqResponseImplFromJson(Map<String, dynamic> json) =>
    _$FaqResponseImpl(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => FaqModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$FaqResponseImplToJson(_$FaqResponseImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
      'pagination': instance.pagination,
    };

_$FaqModelImpl _$$FaqModelImplFromJson(Map<String, dynamic> json) =>
    _$FaqModelImpl(
      question: json['question'] as String,
      answer: json['answer'] as String,
    );

Map<String, dynamic> _$$FaqModelImplToJson(_$FaqModelImpl instance) =>
    <String, dynamic>{
      'question': instance.question,
      'answer': instance.answer,
    };
