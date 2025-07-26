import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/login_model.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://localhost:4000/api")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST("/login")
  Future<LoginResponse> login(@Body() LoginRequest request);
}