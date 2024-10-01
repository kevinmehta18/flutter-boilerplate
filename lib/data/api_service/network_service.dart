
import 'package:boilerplate/constants/uri.dart';
import 'package:dio/dio.dart';

import 'package:retrofit/retrofit.dart';

part 'network_service.g.dart';

@RestApi(baseUrl: "")
abstract class NetworkService {
  factory NetworkService(Dio dio, {String? baseUrl}) = _NetworkService;

  @POST(signUpUrl)
  Future<dynamic> signUp(@Body() FormData data);

  @POST(signInUrl)
  Future<dynamic> login(@Body() Map<String, dynamic> data);

  @POST(verifyOtpUrl)
  Future<dynamic> verifyOtp(@Body() Map<String, dynamic> data);

}
