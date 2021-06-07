import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class RemoteApi {
  //testing api to get pharmacy list
  /*static Future<BaseModel<SearchPharmacyModel>> getPharmacyList(
      String accessToken,
      String searchString,
      int startIndex,
      int pageSize,
      int distanceType,
      double latitude,
      double longitude) async {
    SearchPharmacyRepository searchRepository =
        new SearchPharmacyRepositoryImpl();
    print(startIndex.toString() + " start index");
    BaseModel<SearchPharmacyModel> pharmacy =
        await searchRepository.searchPharmacy(accessToken, searchString,
            startIndex, pageSize, distanceType, latitude, longitude);

    if (pharmacy.getException != null) {
      ServerError _error = pharmacy.getException;

      print(_error.getErrorMessage() + "Avinash");
      throw Exception(_error.getErrorMessage());
    } else {
      return pharmacy;
    }
  }

  // api call to get facility list
  static Future<BaseModel<FacilitySearchModel>> getFacilityList(
      String accessToken,
      String searchString,
      int startIndex,
      int pageSize,
      int distanceType,
      double latitude,
      double longitude) async {
    SearchFacilityRepository searchRepository =
        new SearchFacilityRepositoryImpl();
    print(startIndex.toString() + " start index");
    BaseModel<FacilitySearchModel> pharmacy =
        await searchRepository.searchFacility(accessToken, searchString,
            startIndex, pageSize, distanceType, latitude, longitude);

    if (pharmacy.getException != null) {
      ServerError _error = pharmacy.getException;

      print(_error.getErrorMessage() + "Avinash");
      throw Exception(_error.getErrorMessage());
    } else {
      return pharmacy;
    }
  }

  // api call to get senior care list
  static Future<BaseModel<SearchSeniorCareDetail>> getSeniorCareList(
      String accessToken,
      String searchString,
      int startIndex,
      int pageSize,
      int distanceType,
      double latitude,
      double longitude) async {
    SearchSeniorCareRepository searchRepository =
        new SearchSeniorCareRepositoryImpl();
    print(startIndex.toString() + " start index");
    BaseModel<SearchSeniorCareDetail> seniorCare =
        await searchRepository.searchSeniorCare(accessToken, searchString,
            startIndex, pageSize, distanceType, latitude, longitude);

    if (seniorCare.getException != null) {
      ServerError _error = seniorCare.getException;

      print(_error.getErrorMessage() + "Avinash");
      throw Exception(_error.getErrorMessage());
    } else {
      return seniorCare;
    }
  }

  // api call to get doctor list
  static Future<BaseModel<SearchDoctorModel>> getDoctorList(
      String accessToken,
      String searchString,
      double latitude,
      double longitude,
      bool anp,
      bool ntpa,
      bool primaryCare,
      int speciality,
      int language,
      int startIndex,
      int pageSize) async {
    SearchRepository searchRepository = new SearchRepositoryImpl();
    print(startIndex.toString() + " start index");
    BaseModel<SearchDoctorModel> doctors = await searchRepository.searchDoctors(
        accessToken,
        searchString,
        latitude,
        longitude,
        anp,
        ntpa,
        primaryCare,
        speciality,
        language,
        startIndex,
        pageSize);

    if (doctors.getException != null) {
      ServerError _error = doctors.getException;

      print(_error.getErrorMessage() + "Avinash");
      throw Exception(_error.getErrorMessage());
    } else {
      return doctors;
    }
  }
  */

  //testing api to get pharmacy list
  // static Future<BaseModel<CaffairModel>> getCaffairList(int pageNumber) async {
  //   CaffairRepository searchRepository = new CaffairRepositoryImpl();

  //   BaseModel<CaffairModel> pharmacy =
  //       await searchRepository.getCaffairList(pageNumber);

  //   if (pharmacy.getException != null) {
  //     ServerError _error = pharmacy.getException;

  //     print(_error.getErrorMessage() + "Avinash");
  //     throw Exception(_error.getErrorMessage());
  //   } else {
  //     return pharmacy;
  //   }
  // }
}

class GenericHttpException implements Exception {}

class NoConnectionException implements Exception {}

class _ApiUrlBuilder {
  static const _baseUrl = 'https://www.breakingbadapi.com/api/';
  static const _charactersResource = 'characters/';

  static String characterList(
    int offset,
    int limit, {
    required String searchTerm,
  }) =>
      '$_baseUrl$_charactersResource?'
      'offset=$offset'
      '&limit=$limit'
      '${_buildSearchTermQuery(searchTerm)}';

  static String _buildSearchTermQuery(String searchTerm) =>
      searchTerm.isEmpty == false
          ? '&name=${searchTerm.replaceAll(' ', '+').toLowerCase()}'
          : '';
}

extension on Future<http.Response> {
  Future<R> mapFromResponse<R, T>(R Function(T) jsonParser) async {
    try {
      final response = await this;
      if (response.statusCode == 200) {
        return jsonParser(jsonDecode(response.body));
      } else {
        throw GenericHttpException();
      }
    } on SocketException {
      throw NoConnectionException();
    }
  }
}
