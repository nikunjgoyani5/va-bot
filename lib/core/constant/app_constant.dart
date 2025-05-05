import 'package:logic_go_network/network/rest_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

String baseUrlLive = 'https://vabot.awaazeye.com/api/v1';
String baseUrlDev = 'https://vabot.awaazeye.com/api/v1';
String baseUrl = isLiveMode ? baseUrlLive : baseUrlDev;
late RestClient restClient;
String token = '';
bool isLiveMode = false;
String interFonts = 'Inter';
String dancingScriptFonts = 'DancingScript';
String autografFonts = 'Autograf_PersonalUseOnly';

bool isDarkTheme(BuildContext context) {
  return context.isDarkMode;
}
