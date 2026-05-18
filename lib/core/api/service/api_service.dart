
import '../dio/base_dio.dart';
import 'api_service_interface.dart';

final class ApiService implements IApiService {
  const ApiService({required BaseDio baseDio}) : _baseDio = baseDio;

  final BaseDio _baseDio;

}
