// Mocks generated by Mockito 5.4.2 from annotations
// in ez_text/test/message_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:cloud_firestore/cloud_firestore.dart' as _i2;
import 'package:ez_text/models/message_model.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

import '../message_test.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeCollectionReference_0<T extends Object?> extends _i1.SmartFake
    implements _i2.CollectionReference<T> {
  _FakeCollectionReference_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [MessageTest].
///
/// See the documentation for Mockito's code generation for more information.
class MockMessageRepo extends _i1.Mock implements _i3.MessageTest {
  MockMessageRepo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.CollectionReference<_i4.MessageModel> get messageRef =>
      (super.noSuchMethod(
        Invocation.getter(#messageRef),
        returnValue: _FakeCollectionReference_0<_i4.MessageModel>(
          this,
          Invocation.getter(#messageRef),
        ),
      ) as _i2.CollectionReference<_i4.MessageModel>);
  @override
  set messageRef(_i2.CollectionReference<_i4.MessageModel>? _messageRef) =>
      super.noSuchMethod(
        Invocation.setter(
          #messageRef,
          _messageRef,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i5.Future<void> sendMessage(
    String? message,
    String? Idfrom,
    String? Idto,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #sendMessage,
          [
            message,
            Idfrom,
            Idto,
          ],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Stream<_i2.QuerySnapshot<Map<String, dynamic>>> showMessages(
    String? fromId,
    String? toId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #showMessages,
          [
            fromId,
            toId,
          ],
        ),
        returnValue:
            _i5.Stream<_i2.QuerySnapshot<Map<String, dynamic>>>.empty(),
      ) as _i5.Stream<_i2.QuerySnapshot<Map<String, dynamic>>>);
  @override
  _i5.Future<void> deleteMessage(
    String? fromId,
    String? toId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteMessage,
          [
            fromId,
            toId,
          ],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<String?> showLastFromMessage(
    String? fromId,
    String? toId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #showLastFromMessage,
          [
            fromId,
            toId,
          ],
        ),
        returnValue: _i5.Future<String?>.value(),
      ) as _i5.Future<String?>);
}