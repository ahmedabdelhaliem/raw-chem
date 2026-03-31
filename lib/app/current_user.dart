// // lib/core/utils/current_user.dart

// import 'package:raw_chem/app/imports.dart';
// import 'package:raw_chem/app/user_type.dart';
// import 'package:raw_chem/features/auth/signup/models/auth_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class CurrentUser {
//   final SharedPreferences _prefs;

//   CurrentUser(this._prefs);

//   UserType? _userType;
//   CurrentSubscription? _subscription;

//   UserType? get userType => _userType;
//   CurrentSubscription? get subscription => _subscription;

//   bool get isPlayer => _userType == UserType.player;
//   bool get isCoach => _userType == UserType.coach;
//   bool get isParent => _userType == UserType.parent;

//   Future<void> setUserType(UserType type) async {
//     _userType = type;
//     await _prefs.setString('user_type', type.model.value);
//   }

//   void setSubscription(CurrentSubscription? sub) {
//     _subscription = sub;
//   }

//   Future<void> loadUserType() async {
//     final saved = _prefs.getString('user_type');
//     if (saved != null) {
//       _userType = UserType.values.firstWhere(
//         (e) => e.model.value == saved,
//         orElse: () => UserType.player,
//       );
//     }
//   }

//   Future<void> clear() async {
//     _userType = null;
//     _subscription = null;
//     await _prefs.remove('user_type');
//   }
// }

// CurrentUser get currentUser => instance<CurrentUser>();
