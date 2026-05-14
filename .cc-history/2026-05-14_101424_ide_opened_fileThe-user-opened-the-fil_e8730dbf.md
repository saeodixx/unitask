# Claude Code Session

| Field | Value |
|---|---|
| **Project** | `c:\mobile2-unitask` |
| **Session ID** | `e8730dbf-fd1b-4112-a7d7-58db61233502` |
| **Working Dir** | `c:\mobile2\unitask` |
| **Started** | 2026. 5. 14. 오전 10:14:24 |
| **Last Updated** | 2026. 5. 14. 오전 10:34:25 |
| **Messages** | 11 |

---

## User <sup>2026. 5. 14. 오전 10:14:24</sup>

<ide_opened_file>The user opened the file c:\mobile2\unitask\lib\ui\common\text_divider.dart in the IDE. This may or may not be related to the current task.</ide_opened_file>

@lib/app/router/ 나 이폴더가 뭘 하는건지 모르겠어


---

## Assistant <sup>2026. 5. 14. 오전 10:14:27</sup>


---

## Assistant <sup>2026. 5. 14. 오전 10:14:27</sup>

두 파일을 읽어볼게요.


---

## Assistant <sup>2026. 5. 14. 오전 10:14:28</sup>

<details>
<summary>Tool: <code>Read</code></summary>

```json
{
  "file_path": "c:\\mobile2\\unitask\\lib\\app\\router\\app__router.dart"
}
```

</details>


---

## User <sup>2026. 5. 14. 오전 10:14:28</sup>

<details>
<summary>Tool Result</summary>

```
1	import 'package:go_router/go_router.dart';
2	
3	import 'app_page.dart';
4	
5	final appRouter = GoRouter(
6	  initialLocation: AppPage.login.path,
7	  routes: AppPage.values.map((e) {
8	    return GoRoute(
9	      name: e.name,
10	      path: e.path,
11	      builder: (context, state) => e.page,
12	    );
13	  }).toList(),
14	);
15
```

</details>


---

## Assistant <sup>2026. 5. 14. 오전 10:14:28</sup>

<details>
<summary>Tool: <code>Read</code></summary>

```json
{
  "file_path": "c:\\mobile2\\unitask\\lib\\app\\router\\app_page.dart"
}
```

</details>


---

## User <sup>2026. 5. 14. 오전 10:14:28</sup>

<details>
<summary>Tool Result</summary>

```
1	import 'package:flutter/material.dart';
2	import 'package:unitask/ui/pages/home/home_page.dart';
3	import 'package:unitask/ui/pages/login/login_page.dart';
4	import 'package:unitask/ui/pages/signup/signup_page.dart';
5	
6	enum AppPage { login, signup, home }
7	
8	extension AppPageExtension on AppPage {
9	  String get path => '/$name';
10	  Widget get page => switch (this) {
11	    AppPage.login => const LoginPage(),
12	    AppPage.signup => const SignupPage(),
13	    AppPage.home => const HomePage(),
14	  };
15	}
16
```

</details>


---

## Assistant <sup>2026. 5. 14. 오전 10:14:35</sup>

이 폴더는 **앱의 화면 이동(라우팅)** 을 담당해요.

**`app_page.dart`** — 앱에 있는 페이지 목록 정의
- `AppPage` enum으로 `login`, `signup`, `home` 세 화면을 관리
- 각 페이지의 URL 경로(`/login`, `/signup`, `/home`)와 실제 Widget을 연결

**`app__router.dart`** — 실제 라우터 설정
- `go_router` 패키지를 사용해서 라우터를 만듦
- 앱 시작 시 `/login` 화면으로 이동하도록 설정
- `AppPage`에 등록된 모든 페이지를 자동으로 라우트로 등록

**실제 사용 예시:**
```dart
// 화면 이동할 때 이렇게 씀
context.goNamed(AppPage.home.name);  // 홈으로 이동
context.goNamed(AppPage.signup.name); // 회원가입으로 이동
```

요약하면: **새 페이지를 추가하고 싶으면 `app_page.dart`의 enum에 추가**하면 라우터에 자동으로 등록되는 구조예요.


---

## User <sup>2026. 5. 14. 오전 10:34:14</sup>

<ide_opened_file>The user opened the file c:\mobile2\unitask\lib\models\auth_data.dart in the IDE. This may or may not be related to the current task.</ide_opened_file>

@lib/models/auth_data.dart  이거랑 @lib/services/api_service.dart  이 파일 설명해주라


---

## Assistant <sup>2026. 5. 14. 오전 10:34:18</sup>


---

## Assistant <sup>2026. 5. 14. 오전 10:34:25</sup>

---

## [auth_data.dart](lib/models/auth_data.dart)

로그인 성공 후 서버에서 받아오는 **인증 정보를 담는 데이터 클래스**예요.

| 필드 | 의미 |
|------|------|
| `name` | 사용자 이름 |
| `tokenType` | 토큰 종류 (보통 `"Bearer"`) |
| `accessToken` | API 호출할 때 쓰는 인증 토큰 |
| `refreshToken` | accessToken 만료 시 재발급용 토큰 |
| `expiresAt` | 토큰 만료 시각 (unix timestamp) |
| `expiresIn` | 토큰 유효 시간 (초 단위) |

주요 메서드:
- `fromJson` / `toJson` — 서버 응답(JSON 문자열) ↔ Dart 객체 변환
- `fromMap` / `toMap` — Map ↔ 객체 변환
- `copyWith` — 일부 필드만 바꾼 새 객체 생성

---

## [api_service.dart](lib/services/api_service.dart)

서버와 HTTP 통신을 담당하는 **API 호출 클래스**예요.

**회원가입 (`signup`)**
- `email`, `password`, `name`을 POST로 전송
- 성공 시 `true`, 실패 시 `false` 반환
- `_enableOnce` 플래그로 중복 호출 방지 (버튼 연타 방지용)

**로그인 (`login`)**
- `email`, `password`를 POST로 전송
- 성공 시 응답 JSON을 `AuthData` 객체로 변환해서 반환
- 실패 시 `null` 반환

---

**두 파일의 관계:**
```
서버 응답(JSON) → ApiService.login() → AuthData 객체 → 앱에서 사용
```

로그인하면 `ApiService`가 서버를 호출하고, 성공하면 응답을 `AuthData`로 파싱해서 돌려주는 흐름이에요.


---
