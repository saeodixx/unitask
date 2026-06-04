import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unitask/core/enum/priority.dart';
import 'package:unitask/core/models/result.dart';
import 'package:unitask/features/auth/auth_provider.dart';
import 'package:unitask/models/assignment.dart';
import 'package:unitask/services/assignment_api_service.dart';

final assignmentApiServiceProvider = Provider<AssignmentApiService>(
  (ref) => AssignmentApiService(),
);

//전체 과제 목록, 나머지 분기
final assignmentProvider = AsyncNotifierProvider(AssignmentNotifier.new);

//진행 중인 과제(필터링)
final inProgressAssignmentProvider = Provider(
  (ref) => ref
      .watch(assignmentProvider)
      .whenData((l) => l.where((a) => a.status.isInProgress).toList()),
);
//완료 된 과제(필터링)
final completedAssignmentProvider = Provider(
  (ref) => ref
      .watch(assignmentProvider)
      .whenData((l) => l.where((a) => a.status.isCompleted).toList()),
);

class AssignmentNotifier extends AsyncNotifier<List<Assignment>> {
  //로그인 토큰, 미인증 시 예외처리 필요
  String get _token {
    final token = ref.read(authProvider).value?.accessToken;
    if (token == null) {
      throw StateError('Access token is null');
    }
    return token;
  }

  AssignmentApiService get _api => ref.read(assignmentApiServiceProvider);

  //과제 목록 조회
  @override
  FutureOr<List<Assignment>> build() async {
    final result = await _api.fetchAll(_token);

    return switch (result) {
      Success(:final value) => value,
      Failure(:final exception) => throw exception,
    };
  }

  ///과제 생성
  ///[subjectId] 과제가 속할 과목의 ID
  ///[title] 과제 제목
  /// [description] 과제 설명 (선택)
  /// [dueDate] 과제 마감일
  /// [priority] 과제 우선순위 (기본값: 중간)
  Future<Result<Assignment>> create({
    required String subjectId,
    required String title,
    String? description,
    required DateTime dueDate,
    Priority priority = Priority.medium,
  }) async {
    final result = await _api.create(
      accessToken: _token,
      title: title,
      description: description,
      dueDate: dueDate,
      subjectId: subjectId,
      priority: priority,
    );

    if (result is Success) ref.invalidateSelf();

    return result;
  }

  //과제 업데이트
  Future<Result<Assignment>> updateAssignment({
    required String id,
    String? subjectId,
    String? title,
    String? description,
    DateTime? dueDate,
    Priority? priority,
  }) async {
    final result = await _api.update(
      accessToken: _token,
      id: id,
      subjectId: subjectId,
      title: title,
      description: description,
      dueDate: dueDate,
      priority: priority,
    );

    if (result is Success) ref.invalidateSelf();

    return result;
  }

  //과제 삭제
  Future<Result<void>> deleteAssignment(String id) async {
    final result = await _api.delete(accessToken: _token, id: id);

    if (result is Success) ref.invalidateSelf();

    return result;
  }
}
