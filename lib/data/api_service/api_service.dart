import 'package:asset_management_system/navigation/app_router.dart';
import 'package:asset_management_system/navigation/routes.dart';
import 'package:asset_management_system/presentation/providers/auth/login_provider.dart';
import 'package:asset_management_system/shared_preferences/shared_preference.dart';
import 'package:asset_management_system/utils/toasts.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'network_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ApiService {
  Dio dio = Dio();

  Future<void> refreshToken() async {
    final refreshToken = await PrefUtils().getRefreshToken();
    if (refreshToken.isNotEmpty) {
      try {
        final response = await dio.post(
          'your_refresh_token_endpoint_url',
          data: {
            'refresh_token': refreshToken,
          },
        );
        final newAccessToken = response.data['data']['accessToken'];
        PrefUtils().saveAuthToken(newAccessToken);
      } catch (error) {
        // Handle refresh token error
      }
    }
  }

  void handleUnauthorizedResponse(BuildContext context) {
    showToast(context, 'Unauthorized', toastType: ToastificationType.error);
    context.go(loginRoute);
  }

  bool isErrorResponse(int statusCode, Map<String, dynamic>? responseData) {
    return statusCode != 200 &&
        statusCode != 201 &&
        responseData != null &&
        responseData.containsKey('message');
  }

  void showErrorToast(BuildContext context, String message) {
    showToast(context, message, toastType: ToastificationType.error);
  }

  void stopLoader(BuildContext context) {
    Provider.of<LoginProvider>(context, listen: false).stopLoader();
  }

  void configureInterceptors(BuildContext context) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final accessToken = PrefUtils().getAuthToken().toString();
        if (accessToken.isEmpty) {
          await refreshToken();
        }
        handler.next(options);
      },
      onResponse: (response, handler) {
        if (!kReleaseMode) {
          print("Response received======================>>>>>>>");
        }
        try {
          final responseData = response.data as Map<String, dynamic>?;
          if (isErrorResponse(response.statusCode!, responseData)) {
            final errorMessage = responseData!['message'] as String;
            showErrorToast(context, errorMessage);
          }
        } catch (e, s) {
          if (!kReleaseMode) {
            print(e);
            print(s);
          }
        }
        handler.next(response);
      },
      onError: (e, handler) {
        stopLoader(navigatorKey.currentContext!);
        String errorMessage = '';
        BuildContext context = navigatorKey.currentContext!;

        if (e.response != null) {
          final response = e.response!;
          final statusCode = response.statusCode;
          String errorMessage = getStatusCode(statusCode!);
          if (errorMessage.isNotEmpty) {
            showErrorToast(context, errorMessage);
          }
        } else if (e.type == DioExceptionType.sendTimeout) {
          errorMessage = AppLocalizations.of(context)!.sendTimeoutError;
        } else if (e.type == DioExceptionType.receiveTimeout) {
          errorMessage = AppLocalizations.of(context)!.receiveTimeoutError;
        } else if (e.type == DioExceptionType.connectionTimeout) {
          errorMessage = AppLocalizations.of(context)!.connectionTimeoutError;
        } else if (e.type == DioExceptionType.badResponse) {
          errorMessage = AppLocalizations.of(context)!.badResponseError;
        } else if (e.type == DioExceptionType.badResponse) {
          errorMessage = AppLocalizations.of(context)!.badResponseError;
        } else if (e.type == DioExceptionType.cancel) {
          errorMessage = AppLocalizations.of(context)!.requestCancelledError;
        } else {
          errorMessage = AppLocalizations.of(context)!.internetConnectionError;
        }

        showErrorToast(context, errorMessage);

        if (!kReleaseMode) {
          print('Error Message -> $errorMessage');
        }
      },
    ));
  }

  getStatusCode(int statusCode) {
    String code;
    final statusCodeMap = {
      400: AppLocalizations.of(navigatorKey.currentContext!)!.badRequestError,
      401: AppLocalizations.of(navigatorKey.currentContext!)!.unauthorizedError,
      403: AppLocalizations.of(navigatorKey.currentContext!)!.forbiddenError,
      404: AppLocalizations.of(navigatorKey.currentContext!)!.notFoundError,
      422: AppLocalizations.of(navigatorKey.currentContext!)!
          .unprocessedEntityError,
      500: AppLocalizations.of(navigatorKey.currentContext!)!
          .internalServerError,
      502: AppLocalizations.of(navigatorKey.currentContext!)!.badGatewayError,
      503: AppLocalizations.of(navigatorKey.currentContext!)!
          .serviceUnavailableError,
      504: AppLocalizations.of(navigatorKey.currentContext!)!
          .gatewayTimeoutError,
    };

    if (statusCodeMap.containsKey(statusCode)) {
      code = statusCodeMap[statusCode]!;
    } else {
      code = '';
    }
    return code;
  }

  NetworkService networkService({bool? isMultipartData}) {
    dio.options.connectTimeout = const Duration(milliseconds: 50000);
    dio.options.receiveTimeout = const Duration(milliseconds: 50000);
    dio.options.headers["Content-Type"] =
        (isMultipartData ?? false) ? "multipart/form-data" : "application/json";
    final accessToken = PrefUtils().getAuthToken().toString();
    final deviceUUID = PrefUtils().getDeviceUUID().toString();
    if (accessToken.isNotEmpty) {
      dio.options.headers['Authorization'] = 'Bearer $accessToken';
    }

    if (deviceUUID.isNotEmpty) {
      dio.options.headers['device-uuid'] = deviceUUID;
    }

    return NetworkService(dio, baseUrl: "");
  }
}
