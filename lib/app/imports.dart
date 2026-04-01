import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:raw_chem/app/app_prefs.dart';
import 'package:raw_chem/common/data_source/generic_data_source.dart';
import 'package:raw_chem/common/http/api_consumer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:raw_chem/features/auth/cubit/signup_cubit.dart';
import 'package:raw_chem/features/auth/repo/auth_repo.dart';

import 'app_constants.dart';

part "di.dart";
