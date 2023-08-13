import 'package:ez_text/repositories/auth_repositories.dart';
import 'package:ez_text/repositories/message_repositories.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mockRepos/mockAuthRepo.dart';
import 'mockRepos/mockMessageRepo.dart';

class MessageTest extends Mock  implements MessageRepository{}

@GenerateMocks([MessageTest])
Future<void> main() async {
  late MockMessageRepo mockRepo;

  setUp(() {
    mockRepo = MockMessageRepo();
  });

  test("test to check exception in send messsage", () async{
    when(mockRepo.sendMessage("hello","1","2")).thenAnswer((_) async{
      throw Exception();
    });
    final res= mockRepo.sendMessage("hello","1","2");
    expect(res, throwsException);


  });

  test("test to check exception in delete message", () async{
    when(mockRepo.deleteMessage("1","2")).thenAnswer((_) async{
      throw Exception();
    });
    final res= mockRepo.deleteMessage("1","2");
    expect(res, throwsException);


  });
}
