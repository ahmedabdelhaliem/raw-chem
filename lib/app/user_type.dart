// lib/app/user_type.dart

import 'package:flutter/material.dart';
import 'package:raw_chem/common/resources/assets_manager.dart';

enum UserType {
  player,
  coach,
  parent,
}

class UserTypeModel {
  final int id;
  final String nameAr;
  final String nameEn;
  final String value;
  final String icon;

  const UserTypeModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.value,
    required this.icon,
  });
}

extension UserTypeExtension on UserType {
  UserTypeModel get model {
    switch (this) {
      case UserType.player:
        return const UserTypeModel(
          id: 1,
          nameAr: 'لاعب',
          nameEn: 'Player',
          value: 'player',
          icon: ImageAssets.player,
        );
      case UserType.coach:
        return const UserTypeModel(
          id: 2,
          nameAr: 'مدرب',
          nameEn: 'Coach',
          value: 'coach',
          icon: ImageAssets.trainer,
        );
      case UserType.parent:
        return const UserTypeModel(
          id: 3,
          nameAr: 'ولي أمر',
          nameEn: 'Parent',
          value: 'parent',
          icon: ImageAssets.parent,
        );
    }
  }
}
