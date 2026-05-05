import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_model.freezed.dart';
part 'account_model.g.dart';

@freezed
class Account with _$Account {
  const factory Account({
    required String id,
    required String userId,
    required String name,
    String? broker,
    double? startingBalance,
    @Default('USD') String currency,
    DateTime? createdAt,
  }) = _Account;

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);
}
