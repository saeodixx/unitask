# unitask


유니테스크 시이작!

## 26.04.09
- 로그인 화면 구축
## 26.04.16
- 회원가입 화면, 조건 만들기
- 빌드하기
## 26.5.07
- 오늘은 api 로그인이랑~
- 홈화면 이동하눙거 했더여~
- 중간은 너무 못봤찌만
- 기말은 잘보것이야요!

## 26.05.14 
  오늘 한 것 요약                                                                                                                      
                                                                                                                                       
  1. 상태관리 라이브러리 교체: provider → flutter_riverpod                                                                             
                                                                                                                                     
  - pubspec.yaml에서 provider를 flutter_riverpod ^3.3.1로 교체
  - main.dart에 ProviderScope로 앱 감싸기

  2. 아키텍처 리팩터링 (폴더 구조 개선)

  - lib/core/ 폴더 새로 만들고 extensions, models 이동
    - sized_box_extension → lib/core/extensions/
    - snackbar_extension → lib/core/extensions/build_context_extension.dart로 이동/개선
  - lib/features/auth/ 폴더 생성
  - 기존 api_service.dart 삭제하고 auth_api_service.dart로 분리

  3. Result 타입 도입

  - sealed class Result<T> / Success / Failure 패턴 적용
  - API 에러 처리를 명시적으로 관리

  4. AuthProvider (Riverpod Notifier) 작성

  - AuthProvider가 로그인/회원가입 상태(AsyncValue<AuthData?>) 관리
  - 로딩 상태, 에러 상태 자동 처리

  5. LoginPage / SignupPage Riverpod으로 전환

  - StatefulWidget → ConsumerStatefulWidget
  - 직접 API 호출하던 것 → ref.read(authProvider.notifier).login/signup() 으로 변경
  - 로그인 버튼에 로딩 스피너(CircularProgressIndicator) 추가
  - switch (result) 패턴으로 성공/실패 분기 처리

  ---
  한마디로: "날것의 직접 API 호출 코드"를 "Riverpod 기반의 구조화된 상태관리 코드"로 리팩터링한 날이었어요.