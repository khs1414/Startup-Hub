import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'start_up_record.g.dart';

abstract class StartUpRecord
    implements Built<StartUpRecord, StartUpRecordBuilder> {
  static Serializer<StartUpRecord> get serializer => _$startUpRecordSerializer;

  @nullable
  BuiltList<String> get password;

  @nullable
  @BuiltValueField(wireName: 'display_name')
  String get displayName;

  @nullable
  String get uid;

  @nullable
  @BuiltValueField(wireName: 'created_time')
  DateTime get createdTime;

  @nullable
  @BuiltValueField(wireName: 'phone_number')
  String get phoneNumber;

  @nullable
  String get email;

  @nullable
  @BuiltValueField(wireName: 'photo_url')
  String get photoUrl;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(StartUpRecordBuilder builder) => builder
    ..password = ListBuilder()
    ..displayName = ''
    ..uid = ''
    ..phoneNumber = ''
    ..email = ''
    ..photoUrl = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('start_up');

  static Stream<StartUpRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<StartUpRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  StartUpRecord._();
  factory StartUpRecord([void Function(StartUpRecordBuilder) updates]) =
      _$StartUpRecord;

  static StartUpRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createStartUpRecordData({
  String displayName,
  String uid,
  DateTime createdTime,
  String phoneNumber,
  String email,
  String photoUrl,
}) =>
    serializers.toFirestore(
        StartUpRecord.serializer,
        StartUpRecord((s) => s
          ..password = null
          ..displayName = displayName
          ..uid = uid
          ..createdTime = createdTime
          ..phoneNumber = phoneNumber
          ..email = email
          ..photoUrl = photoUrl));
