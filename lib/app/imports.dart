import 'dart:developer';

import 'package:raw_chem/app/app_prefs.dart';
import 'package:raw_chem/app/current_user.dart';
import 'package:raw_chem/common/data_source/generic_data_source.dart';
import 'package:raw_chem/common/http/api_consumer.dart';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'app_constants.dart';



part "di.dart";
