import 'package:dio/dio.dart';
import 'package:project_tractian/models/asset_model.dart';
import 'package:project_tractian/models/location_model.dart';
import 'dart:developer';

import '../models/enterprise_model.dart';

class GeneralRepository {
  final Dio dio = Dio();

  Future<List<EnterpriseModel>> getEnterprise() async {
    List<EnterpriseModel> enterprises = [];

    try {
      String url = 'http://fake-api.tractian.com/companies';
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        enterprises = (response.data as List)
            .map((enterprise) => EnterpriseModel.fromJson(enterprise))
            .toList();
      } else {
        throw Exception('Erro ao buscar empresas: ${response.statusCode}');
      }
    } catch (e) {
      log('Erro ao buscar empresas: $e');
    }
    return enterprises;
  }

  Future<List<LocationModel>> getLocations(String companyId) async {
    List<LocationModel> locations = [];
    try {
      String url =
          'http://fake-api.tractian.com/companies/$companyId/locations';
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        locations = (response.data as List)
            .map((enterprise) => LocationModel.fromJson(enterprise))
            .toList();
      } else {
        throw Exception('Erro ao buscar Locations: ${response.statusCode}');
      }
    } catch (e) {
      log('Erro ao buscar empresas: $e');
    }
    return locations;
  }

  Future<List<AssetModel>> getAssets(String companyId) async {
    List<AssetModel> assets = [];
    try {
      String url = 'http://fake-api.tractian.com/companies/$companyId/assets';
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        assets = (response.data as List)
            .map((enterprise) => AssetModel.fromJson(enterprise))
            .toList();
      } else {
        throw Exception('Erro ao buscar Locations: ${response.statusCode}');
      }
    } catch (e) {
      log('Erro ao buscar assets: $e');
    }
    return assets;
  }
}
