import 'package:ez_text/models/user_model.dart';
import 'package:ez_text/repositories/auth_repositories.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mockRepos/mockAuthRepo.dart';

class ChangePasswordTest extends Mock  implements AuthRepository{}

@GenerateMocks([ChangePasswordTest])
Future<void> main() async {


  late MockAuthRepo mockRepo;

  setUp(() {
    mockRepo = MockAuthRepo();
  });

  test("testing changePassword", () async{

    final model= UserModel();

    when(mockRepo.changePassword("NewPassword","123")).thenAnswer((_) async{
      return true;
    });
    final result = await mockRepo.changePassword("NewPassword","123");
    expect(result, true);
  });

  test("testing exception in changePassword", () async{
    when(mockRepo.changePassword("123", "12")).thenAnswer((_) async {
      throw Exception();
    });

    final result = mockRepo.changePassword("123", "12");
    expect(result, throwsException);
  }
  );




}