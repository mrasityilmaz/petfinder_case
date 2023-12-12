import 'package:flutter/material.dart';

@immutable
final class BaseResponseModel<T> {
  const BaseResponseModel({
    required this.success,
    this.data,
  });

  factory BaseResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic jsonValue) fromJsonT,
  ) {
    return BaseResponseModel<T>(
      success: json['status'].toString() == 'success',
      data: json['message'] != null ? fromJsonT(json['message']) : null,
    );
  }
  final bool success;
  final T? data;
}
