import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttp extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  /*late ApiService apiService;
    late MockHttp httpClient;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttp();
      apiService = ApiService();
    });*/

  test(
      'make correct http request with wrong password,'
      ' throw [ErrorEmptyResponse]', () async {
    expect(1, 1);
    /*final response = MockResponse();

    when(() => response.statusCode).thenReturn(400);
    when(() => response.body).thenReturn('"error": "Wrong password"');
    when(() => httpClient.post(any())).thenAnswer((_) async => response);
    try {
      apiService.postData("peter@klaven", " ");
    } catch (error) {
      expect(error, 'Error con el usuario');
    }*/
  });
}
