// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../Pages/tabs/CategoriesTab.dart';
import '../../Pages/tabs/HomeTab.dart';
import '../../Pages/tabs/ImageTab.dart';

List tabsPages = [
  const HomeTab(),
  const CategoriesTab(),
  const SizedBox(),
  ImageTab(),
];
