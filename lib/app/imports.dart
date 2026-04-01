import 'package:dio/dio.dart';
import 'package:raw_chem/core/api/api_endpoints.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:raw_chem/app/app_prefs.dart';
import 'package:raw_chem/common/data_source/generic_data_source.dart';
import 'package:raw_chem/common/http/api_consumer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:raw_chem/features/auth/cubit/signup_cubit.dart';
import 'package:raw_chem/features/auth/cubit/verify_otp_cubit.dart';
import 'package:raw_chem/features/auth/cubit/forgot_pwd_cubit.dart';
import 'package:raw_chem/features/auth/cubit/login_cubit.dart';
import 'package:raw_chem/features/profile/cubit/profile_cubit.dart';
import 'package:raw_chem/features/profile/cubit/faq_cubit.dart';
import 'package:raw_chem/features/profile/model/faq/faq_model.dart';
import 'package:raw_chem/features/profile/cubit/static_pages_cubit.dart';
import 'package:raw_chem/features/auth/repo/auth_repo.dart';

export '../features/auth/repo/auth_repo.dart';
export '../features/auth/cubit/signup_cubit.dart';
export '../features/auth/cubit/verify_otp_cubit.dart';
export '../features/auth/cubit/forgot_pwd_cubit.dart';
export '../features/auth/cubit/login_cubit.dart';
export '../features/profile/cubit/faq_cubit.dart';
export '../features/profile/cubit/profile_cubit.dart';
export '../features/profile/cubit/static_pages_cubit.dart';
export '../features/profile/model/faq/faq_model.dart';
export '../features/profile/model/profile/profile_model.dart';

import 'app_constants.dart';

part "di.dart";
