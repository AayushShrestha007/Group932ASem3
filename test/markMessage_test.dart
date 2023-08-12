import 'package:ez_text/models/user_model.dart';
import 'package:ez_text/repositories/auth_repositories.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mockRepos/mockAuthRepo.dart';

class MarkMessageTest extends Mock  implements AuthRepository{}

@GenerateMocks([MarkMessageTest])
Future<void> main() async {
  late MockAuthRepo mockRepo;

  setUp(() {
    mockRepo = MockAuthRepo();
  });


  test("testing marked message", () async {
    final model = UserModel();

    when(mockRepo.addFavorite(model, "12","hello@gmail.com")).thenAnswer((_) async{
      return model;
    });
    final res= await mockRepo.addFavorite(model, "12","hello@gmail.com");
    expect(res, isA<UserModel>());
    expect(res,model);
  });

  test("test to see if exception is thrown or not in mark favorite feature", (){
    final model = UserModel();
    when(mockRepo.addFavorite(model, "12","hello@gmail.com")).thenAnswer((_) async{
      throw Exception();
    });
    final res= mockRepo.addFavorite(model, "12","hello@gmail.com");
    expect(res, throwsException);

  });
}