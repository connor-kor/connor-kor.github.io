---
title: SNS 프로젝트
category: project
---

## 1. 유튜브 API

**API**

> Youtube Data API(v3)

유튜브와 관련된 기본적인 API로, 동영상을 업로드하거나 재생목록을 관리하는 등의 가장 기본적인 기능 제공

> Youtube Analytics API

유튜브의 동영상 및 채널에 대한 시청 통계, 인기도 통계 등 검색

> Youtube Live Streaming API

유튜브 방송을 예약하고 , 라이브 스트림을 관리

이중 기본 기능을 제공하지만 가장 중요한 것은 Data API다. Data API는 다음과 같은 리소스들의 기능을 다루고 있다. (각 리소스에 대한 설명은 [3.API 살펴보기](https://brunch.co.kr/@joypinkgom/54)를 참고한다.)

> Channels

채널의 설명, 대표 이미지, 조회 수, 구독자 수, 동영상 수

카테고리에 맞는 채널 검색

\> 특정 채널에 대한 정보 검색(내채널 조회, 채널이름 조회, 채널아이디 조회)

\> 채널 메타데이터 업데이트

> Playlists,  PlaylistItems

재생목록의 제목, 설명, 썸네일 및 url

메뉴얼: <https://brunch.co.kr/@joypinkgom/76>{:target="_blank"}

\> 자신 또는 특정 사용자의 재생목록조회

\> 재생목록 추가/수정/삭제

\> 재생목록 정보 조회

\> 재생목록에 리소스 추가

\> 재생목록의 리소스 수정/삭제

> Videos

제목과 설명, 자막여부 및 조회 수, 좋아요 수, 자막 수

동영상 업로드

\> 동영상 목록 조회

\> 동영상 업로드, 메타데이터 설정

\> 동양상 메타데이터 업데이트

\> 동영상 삭제

\> 동영상 좋아요/싫어요 평가 추가/삭제

> Search

조회 수 순서대로 제목, 설명, 조회 수, 댓글 수, 좋아요 수, 업로드 일시

\> 검색 조건에 해당하는 동영상/채널/재생목록 조회

> Activities

\> 특정 채널이나 사용자가 유튜브에서 실행한 작업의 정보(동영상 평가, 동영상 공유, 동영상을 즐겨찾기에 추가, 동영상에 댓글 달기, 동영상 업로드 등)를 조회

> Captions

\> 자막 목록 조회, 자막 삭제

\> 자막 파일 등록, 업데이트, 다운로드

> Comments

\> 채널(토론) 또는 동영상에 달린 댓글목록 조회

\> 댓글 추가/수정/삭제 

\> 특정 댓글 스팸 처리

> Subscriptions

\> 특정 채널을 구독/삭제

\> 구독 채널 목록 조회

**시작하기**

사용자 인증 정보에서 새 프로젝트를 만든다.



youtube api 라고 검색하고 시작한다.

사용자 인증 정보 탭의 사용자 인증 정보 만들기를 클릭하고 서비스 계정을 클릭한다.

1. 프로젝트 만들기 및 Youtube api 사용 및 API 키 생성
2. 레트로핏 라이브러리, 인터넷 권한 추가
3. 포스트맨 참고하여 데이터클래스 생성
4. 서비스 인터페이스 생성

프로젝트 만들기: <https://console.cloud.google.com/projectselector2/apis/credentials?hl=ko&pli=1&supportedpurview=project>{:target="_blank"}

**build.gradle(app)**

```
/* 레트로핏 */
implementation 'com.squareup.retrofit2:retrofit:2.9.0'
implementation 'com.squareup.retrofit2:converter-gson:2.9.0'
```

**서비스 인터페이스**

```kotlin
interface 데이터Service {
    @GET("링크")
    fun get데이터(
        @Query("key") apiKey: String
    ): Call<데이터>
}
```

> 데이터클래스에서 @SerializedName 는 꼭 필요하지 않다.

**메인액티비티**

```kotlin
/* 레트로핏: API 라이브러리 */
val retrofit = Retrofit.Builder()
    .baseUrl("주소")
    .addConverterFactory(GsonConverterFactory.create())
    .build()
val 데이터Service = retrofit.create(데이터Service::class.java)
데이터Service.get함수("키")
    .enqueue(object: Callback<데이터> {
        override fun onResponse(
            call: Call<데이터>,
            response: Response<데이터>
        ) {
            // todo 성공처리
            if (response.isSuccessful.not()) {
                Log.e("TAG", "Not!! Success")
                return
            }
            response.body()?.let {
                Log.d("TAG", it.toString())
                it.객체.forEach {
                    Log.d("TAG", it.toString())
                }
            }
        }

        override fun onFailure(call: Call<Youtube>, t: Throwable) {
            // TODO("Not yet implemented")
        }
    })
```





Q. onStart 는 finish() 때 호출되나?

A. 네

**파이어베이스 계정삭제**

```kotlin
private fun deleteUser() {
    // [START delete_user]
    val user = auth.currentUser

    if (user != null) {
        user.delete()
            .addOnCompleteListener { task ->
                if (task.isSuccessful) {
                    Log.d("TAG", "User account deleted.")
                }
            }
    }
    // [END delete_user]
}
```

**이전 로그인으로 자동로그인 하는 현상**

구글로그인 버튼을 눌렀을 때 계정선택창이 뜨지않고 자동로그인 되는 현상을 막을 수 있다.

```kotlin
/* 자동로그인 해제 */
val gso = GoogleSignInOptions.Builder(GoogleSignInOptions.DEFAULT_SIGN_IN)
    .requestIdToken(getString(R.string.default_web_client_id))
    .requestEmail()
    .build()
googleSignInClient = GoogleSignIn.getClient(this, gso)

googleSignInClient.signOut()

```



**썸네일**

**editText.text.**

`substring()`

`indexOf()` 

`split()` 특정 문자를 기준으로 잘라 문자열 리스트를 반환합니다.

```kotlin
var startIndex = editText.text.indexOf('=')
var endIndex = editText.text.indexOf('&')
val videoId = editText.text.substring(startIndex, endIndex)  // =5iZCU6mS_CY
```

startIndex 포함, endIndex 미포함

**이미지링크**

![image-20210802223708389](../../../assets/images/image-20210802223708389.png)

```kotlin
class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val textView = findViewById<TextView>(R.id.textView)
        val editText = findViewById<EditText>(R.id.editText)
        val button = findViewById<Button>(R.id.button)

        button.setOnClickListener {
            var startIndex = editText.text.indexOf('=')
            var endIndex = editText.text.indexOf('&')
            val videoId = editText.text.substring(startIndex + 1, endIndex)
            var imageLink = "https://img.youtube.com/vi/" + videoId + "/maxresdefault.jpg"
            textView.setText(imageLink)
        }
    }
}
```

웹서버에 이미지를 불러오기 위해 이번에는 glide 라는 라이브러리를 활용해보겠다.

![image-20210802225222474](../../../assets/images/image-20210802225222474.png)

### glide

**build.gradle**

```
implementation 'com.github.bumptech.glide:glide:4.11.0'
annotationProcessor 'com.github.bumptech.glide:compiler:4.11.0'
```

**manifest**

```
<uses-permission android:name="android.permission.INTERNET"/>
```

Glide 후에 with, load, into 메소드 세 개를 사용하면 쉽게 사용할 수 있다.

```kotlin
class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val textView = findViewById<TextView>(R.id.textView)
        val editText = findViewById<EditText>(R.id.editText)
        val imageView = findViewById<ImageView>(R.id.imageView)
        val button = findViewById<Button>(R.id.button)

        button.setOnClickListener {
            var startIndex = editText.text.indexOf('=')
            var endIndex = editText.text.indexOf('&')
            val videoId = editText.text.substring(startIndex + 1, endIndex)
            var imageURL = "https://img.youtube.com/vi/" + videoId + "/maxresdefault.jpg"
            textView.setText(imageURL)
            Glide.with(this)
                .load(imageURL)
                .into(imageView)
        }
    }
}
```

**리사이클러뷰에 넣는방법**

```kotlin
/* 글라이드: 이미지 URL 라이브러리 */
Glide.with(binding.imageviewYoutubeVideo.context)
    .load(item.snippet.thumbnails.maxres.url)
    .into(binding.imageviewYoutubeVideo)
```



**오류수정 및 지우기버튼 추가**

유튜브 URL 에서 특수문자 & 가 없는 경우도 있어 앱이 비정상 종료 되었다. if 문으로 예외처리 했다.

```kotlin
class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val textView = findViewById<TextView>(R.id.textView)
        val editText = findViewById<EditText>(R.id.editText)
        val imageView = findViewById<ImageView>(R.id.imageView)

        /* 유튜브 썸네일 추가 버튼 */
        val button = findViewById<Button>(R.id.button)
        button.setOnClickListener {
            var startIndex = editText.text.indexOf('=')
            lateinit var videoId: String

            /* 입력한 유튜브 영상의 썸네일 가져오기 */
            if (editText.text.contains('&')) {
                var endIndex = editText.text.indexOf('&')
                videoId = editText.text.substring(startIndex + 1, endIndex)
            } else {
                videoId = editText.text.substring(startIndex + 1)
            }
            var imageURL = "https://img.youtube.com/vi/" + videoId + "/maxresdefault.jpg"
            textView.setText(imageURL)
            Glide.with(this)
                .load(imageURL)
                .into(imageView)
        }

        /* URL 지우는 버튼 */
        val buttonDelete = findViewById<Button>(R.id.delete)
        buttonDelete.setOnClickListener {
            editText.setText("")
        }
    }
}
```

**썸네일 클릭 시 유튜브 연결**

```kotlin
class MainActivity : AppCompatActivity() {
    var videoURL: String? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val textView = findViewById<TextView>(R.id.textView)
        val editText = findViewById<EditText>(R.id.editText)
        val imageView = findViewById<ImageView>(R.id.imageView)

        /* 유튜브 썸네일 추가 버튼 */
        val button = findViewById<Button>(R.id.button)
        button.setOnClickListener {
            if (editText.text.toString() != "") {
                var startIndex = editText.text.indexOf('=')
                lateinit var videoId: String

                /* 입력한 유튜브 영상의 썸네일 가져오기 */
                if (editText.text.contains('&')) {
                    var endIndex = editText.text.indexOf('&')
                    videoId = editText.text.substring(startIndex + 1, endIndex)
                } else {
                    videoId = editText.text.substring(startIndex + 1)
                }
                var imageURL = "https://img.youtube.com/vi/" + videoId + "/maxresdefault.jpg"
                textView.setText(imageURL)
                Glide.with(this)
                    .load(imageURL)
                    .into(imageView)
                videoURL = editText.text.toString()
                editText.setText("")
            }
        }

        /* URL 지우는 버튼 */
        val buttonDelete = findViewById<Button>(R.id.delete)
        buttonDelete.setOnClickListener {
            editText.setText("")
        }

        /* 유튜브 연결 버튼 */
        imageView.setOnClickListener {
            if (videoURL != null) {
                var intent = Intent(Intent.ACTION_VIEW, Uri.parse(videoURL))
                try {
                startActivity(intent)
                } catch(e: Exception) {
                    textView.setText("올바른 URL 이 아닙니다.")
                    e.printStackTrace()
                }
            }
        }
    }
}
```

---

**참조**

유튜브 API: <https://blog.naver.com/PostView.nhn?blogId=deathrock&logNo=221701778199>{:target="_blank"}

## 2. 파이어베이스

**Firebase 연결**

1. 앱 등록
2. google-services 파일 app 폴더에 저장
3. Firebase SDK 를 프로젝트 수준의 build.gradle 과 앱 수준의 build.gradle 에 추가

**프로젝트 수준 build.gradle**

buildscript {
    dependencies { 내부

```
/* 파이어베이스 SDK */
classpath 'com.google.gms:google-services:4.3.8'
```

**앱 수준 build.gradle**

plugins { 내부

```
/* 파이어베이스 SDK */
id 'com.google.gms.google-services'
```

dependencies { 내부

> platform 과 괄호를 없애지 않고 그대로 복사 붙여넣기한다.

```
/* 파이어베이스 SDK */
implementation platform('com.google.firebase:firebase-bom:28.3.0')
```

기타 다른 라이브러리들을 dependencies 내부에 추가합니다.

다른 라이브러리: <https://firebase.google.com/docs/android/setup#available-libraries>{:target="_blank"}

**구글 로그인**

1> 앱 수준 build.gradle 파일 dependencies { 내부에 추가

**위에서 firebase-bom 라이브러리를 추가했다면**

```
/* 구글로그인 */
implementation 'com.google.firebase:firebase-auth-ktx'
implementation 'com.google.android.gms:play-services-auth:19.2.0'
```

**아니라면**

```
/* 구글로그인 */
// Import the BoM for the Firebase platform
implementation platform('com.google.firebase:firebase-bom:28.2.1')
// Declare the dependency for the Firebase Authentication library
// When using the BoM, you don't specify versions in Firebase library dependencies
implementation 'com.google.firebase:firebase-auth-ktx'
// Also declare the dependency for the Google Play services library and specify its version
implementation 'com.google.android.gms:play-services-auth:19.2.0'
```

2> SHA-1 디지털 지문을 지정한다.

**SHA-1 인증서 얻는법**

1. cmd 실행
2. 안드로이드 스튜디오의 루트디렉토리 .android 로 이동한다.
3. 다음과 같은 코드를 입력하고 비밀번호로 `android` 를 입력한다.

```
keytool -list -v -keystore debug.keystore
```

![image-20210807005723771](../../../assets/images/image-20210807005723771.png)

3> 파이어베이스 인증탭에서 구글로그인을 사용으로 설정하고 저장

4> 다음 파일을 저장 후 패키지명 변경

파일위치: <https://github.com/firebase/snippets-android/blob/03cf10de9e46f7ddbd621ae04ac2da1f590dd649/auth/app/src/main/java/com/google/firebase/quickstart/auth/kotlin/GoogleSignInActivity.kt#L33-L39>{:target="_blank"}

메뉴얼: <https://firebase.google.com/docs/auth/android/google-signin?authuser=2>{:target="_blank"}

```kotlin
/**
 * Demonstrate Firebase Authentication using a Google ID Token.
 */
class GoogleSignInActivity : Activity() {

    // [START declare_auth]
    private lateinit var auth: FirebaseAuth
    // [END declare_auth]

    private lateinit var googleSignInClient: GoogleSignInClient

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // [START config_signin]
        // Configure Google Sign In
        val gso = GoogleSignInOptions.Builder(GoogleSignInOptions.DEFAULT_SIGN_IN)
                .requestIdToken(getString(R.string.default_web_client_id))
                .requestEmail()
                .build()

        googleSignInClient = GoogleSignIn.getClient(this, gso)
        // [END config_signin]


        // [START initialize_auth]
        // Initialize Firebase Auth
        auth = Firebase.auth
        // [END initialize_auth]
    }

    // [START on_start_check_user]
    override fun onStart() {
        super.onStart()
        // Check if user is signed in (non-null) and update UI accordingly.
        val currentUser = auth.currentUser
        updateUI(currentUser)
    }
    // [END on_start_check_user]

    // [START onactivityresult]
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        // Result returned from launching the Intent from GoogleSignInApi.getSignInIntent(...);
        if (requestCode == RC_SIGN_IN) {
            val task = GoogleSignIn.getSignedInAccountFromIntent(data)
            try {
                // Google Sign In was successful, authenticate with Firebase
                val account = task.getResult(ApiException::class.java)!!
                Log.d(TAG, "firebaseAuthWithGoogle:" + account.id)
                firebaseAuthWithGoogle(account.idToken!!)
            } catch (e: ApiException) {
                // Google Sign In failed, update UI appropriately
                Log.w(TAG, "Google sign in failed", e)
            }
        }
    }
    // [END onactivityresult]

    // [START auth_with_google]
    private fun firebaseAuthWithGoogle(idToken: String) {
        val credential = GoogleAuthProvider.getCredential(idToken, null)
        auth.signInWithCredential(credential)
                .addOnCompleteListener(this) { task ->
                    if (task.isSuccessful) {
                        // Sign in success, update UI with the signed-in user's information
                        Log.d(TAG, "signInWithCredential:success")
                        val user = auth.currentUser
                        updateUI(user)
                    } else {
                        // If sign in fails, display a message to the user.
                        Log.w(TAG, "signInWithCredential:failure", task.exception)
                        updateUI(null)
                    }
                }
    }
    // [END auth_with_google]

    // [START signin]
    private fun signIn() {
        val signInIntent = googleSignInClient.signInIntent
        startActivityForResult(signInIntent, RC_SIGN_IN)
    }
    // [END signin]

    private fun updateUI(user: FirebaseUser?) {

    }

    companion object {
        private const val TAG = "GoogleActivity"
        private const val RC_SIGN_IN = 9001
    }
}
```

5> R 을 import

6> default_web_client_id 가 빨간상태에서 앱을 실행하면 자동으로 값이 저장된다.

7> R import 를 없앤다.

**구글로그인 버튼**

```xml
<com.google.android.gms.common.SignInButton
    android:layout_width="wrap_content"
    android:layout_height="wrap_content"
</com.google.android.gms.common.SignInButton>
```

`SignInButton` 타입으로 findViewById 를 해주어야 한다.

**GoogleSignInActivity**

![image-20210807020005122](../../../assets/images/image-20210807020005122.png)

```kotlin
/**
 * Demonstrate Firebase Authentication using a Google ID Token.
 */
class GoogleSignInActivity : Activity() {

    private lateinit var textView: TextView
    private lateinit var textView2: TextView
    private lateinit var textView3: TextView
    private lateinit var textView4: TextView

    // [START declare_auth]
    private lateinit var auth: FirebaseAuth
    // [END declare_auth]

    private lateinit var googleSignInClient: GoogleSignInClient

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_login)

        val btn_googleLogin = findViewById<SignInButton>(R.id.btn_googleLogin)
        btn_googleLogin.setOnClickListener {
            signIn()
        }

        // [START config_signin]
        // Configure Google Sign In
        val gso = GoogleSignInOptions.Builder(GoogleSignInOptions.DEFAULT_SIGN_IN)
                .requestIdToken(getString(R.string.default_web_client_id))
                .requestEmail()
                .build()

        googleSignInClient = GoogleSignIn.getClient(this, gso)
        // [END config_signin]


        // [START initialize_auth]
        // Initialize Firebase Auth
        auth = Firebase.auth
        // [END initialize_auth]
    }

    // [START on_start_check_user]
    override fun onStart() {
        super.onStart()
        // Check if user is signed in (non-null) and update UI accordingly.
        val currentUser = auth.currentUser
        updateUI(currentUser)
    }
    // [END on_start_check_user]

    // [START onactivityresult]
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        // Result returned from launching the Intent from GoogleSignInApi.getSignInIntent(...);
        if (requestCode == RC_SIGN_IN) {
            val task = GoogleSignIn.getSignedInAccountFromIntent(data)
            try {
                // Google Sign In was successful, authenticate with Firebase
                val account = task.getResult(ApiException::class.java)!!
                Log.d(TAG, "firebaseAuthWithGoogle:" + account.id)
                firebaseAuthWithGoogle(account.idToken!!)
            } catch (e: ApiException) {
                // Google Sign In failed, update UI appropriately
                Log.w(TAG, "Google sign in failed", e)
            }
        }
    }
    // [END onactivityresult]

    // [START auth_with_google]
    private fun firebaseAuthWithGoogle(idToken: String) {
        val credential = GoogleAuthProvider.getCredential(idToken, null)
        auth.signInWithCredential(credential)
                .addOnCompleteListener(this) { task ->
                    if (task.isSuccessful) {
                        // Sign in success, update UI with the signed-in user's information
                        Log.d(TAG, "signInWithCredential:success")
                        val user = auth.currentUser
                        updateUI(user)
                    } else {
                        // If sign in fails, display a message to the user.
                        Log.w(TAG, "signInWithCredential:failure", task.exception)
                        updateUI(null)
                    }
                }
    }
    // [END auth_with_google]

    // [START signin]
    private fun signIn() {
        val signInIntent = googleSignInClient.signInIntent
        startActivityForResult(signInIntent, RC_SIGN_IN)
    }
    // [END signin]

    private fun updateUI(user: FirebaseUser?) {
        if (user != null) {
            Toast.makeText(this, "로그인에 성공했습니다.", Toast.LENGTH_SHORT).show()
            textView.setText(user.displayName)
            textView2.setText(user.email)
        }
    }

    companion object {
        private const val TAG = "GoogleActivity"
        private const val RC_SIGN_IN = 9001
    }
}
```

**FirebaseAuth 객체 vs FirebaseUser 객체**

FirebaseAuth 객체

getInstance() 메소드로 인스턴스를 반환한 후 로그인하고 currentUser() 메소드를 사용하여 로그인정보를 담고있는 FirebaseUser 객체를 얻습니다.

First, obtain an instance of this class by calling `getInstance()`.

Then, sign up or sign in a user with one of the following methods:

Finally, call `getCurrentUser()` to get a `FirebaseUser` object, which contains information about the signed-in user.

이것은 Intent 로 객체를 넘겨줄 필요 없이 어디서든 얻을 수 있습니다.

```kotlin
var user = FirebaseAuth.getInstance().currentUser
val name = findViewById<TextView>(R.id.name)
val email = findViewById<TextView>(R.id.email)

name.setText(user?.displayName)
email.setText(user?.email)
```

메뉴얼: <https://firebase.google.com/docs/reference/android/com/google/firebase/auth/FirebaseAuth?authuser=2#nested-class-summary>{:target="_blank"}

**로그아웃**

```kotlin
Firebase.auth.signOut()
```

**로그인확인**

로그인이 되어있는지 확인 후 로그인되어있지 않다면 GoogleSignInActivity 화면으로 이동한다.

```kotlin
override fun onStart() {
    super.onStart()
    val currentUser = Firebase.auth.currentUser
    updateUI(currentUser)
}

private fun updateUI(currentUser: FirebaseUser?) {
    if (currentUser == null) {
        startActivity(Intent(this, GoogleSignInActivity::class.java))
    }
}
}
```

```
FirebaseAuth.getInstance()
Firebase.auth
```

두 코드는 같은 코드인 것 같다.

**로그인 정보 가져오기**

```kotlin
val user = Firebase.auth.currentUser
user?.let {
    Log.e("TAG", "displayName: " + user.displayName)
    Log.e("TAG", "email: " + user.email)
    Log.e("TAG", "uid: " + user.uid)
    Log.e("TAG", "photoUrl: " + user.photoUrl)
    Log.e("TAG", "isEmailVerified: " + user.isEmailVerified)
    Log.e("TAG", "providerId: " + user.providerId)
}
```

**결과**

```kotlin
E/TAG: displayName: 김현준
    email: kor.jturtle@gmail.com
    uid: lSBHEh4dbHZRRvueqajffNEqRcj1
    photoUrl: https://lh3.googleusercontent.com/a-/AOh14GidAquTtiiyHQayhnj1JVC2Q1E0-NTNFfaqe-OQ=s96-c
E/TAG: isEmailVerified: true
    providerId: firebase
```

메뉴얼: <https://firebase.google.com/docs/auth/android/manage-users?hl=ko>{:target="_blank"}

**Realtime Database**

build.gradle(app) 에 추가

```
dependencies {
    // Import the BoM for the Firebase platform
    implementation platform('com.google.firebase:firebase-bom:28.3.0')

    // Declare the dependency for the Realtime Database library
    // When using the BoM, you don't specify versions in Firebase library dependencies
    implementation 'com.google.firebase:firebase-database-ktx'
}
```

```
implementation 'com.google.firebase:firebase-database-ktx'
```

**쓰기**

메뉴얼

```kotlin
// Write a message to the database
val database = Firebase.database
val myRef = database.getReference("message")

myRef.setValue("Hello, World!")
```

**패스트캠퍼스**

```kotlin
private fun handleSuccessLogin() {
    if (auth.currentUser == null) {
        Toast.makeText(this, "로그인에 실패했습니다.", Toast.LENGTH_SHORT).show()
        return
    }
    val userId = auth.uid.orEmpty()
    val database = Firebase.database.reference.child("Users").child(userId)
    val user = mutableMapOf<String, Any>()
    user["userId"] = userId
    database.updateChildren(user)
}
```

>Firebase Database paths must not contain '.', '#', '$', '[', or ']'
>
>데이터베이스 경로에는 특수기호를 넣을 수 없다.

**null 이 아닌 값 저장하기**

1. orEmpty() 메소드로 null 일 경우 값을 비운다.
2. let 으로 감싸서 null 이 아닐경우 값을 저장한다.

**데이터 쓰기**

updateUI 에 넣습니다.

```kotlin
private fun handleSuccessLogin() {
    if (auth.currentUser == null) {
        Toast.makeText(this, "로그인에 실패했습니다.", Toast.LENGTH_SHORT).show()
        return
    }
    val userId = auth.uid.orEmpty()
    val database = Firebase.database.reference.child("Users").child(userId)
    val user = mutableMapOf<String, Any>()
    user["userId"] = userId
    database.updateChildren(user)
}
```

**예시**

```kotlin
private fun saveLoginInfo(user: FirebaseUser?) {
    user?.let {
        val database = Firebase.database.reference.child("Users").child(user.uid)
        val userInfo = mutableMapOf<String, Any>()
        userInfo["name"] = user.displayName.toString()
        userInfo["email"] = user.email.toString()
        userInfo["photoUrl"] = user.photoUrl.toString()
        database.updateChildren(userInfo)
    }
}
```

**데이터 추가**

```kotlin
class LikeActivity : AppCompatActivity() {
    private var auth: FirebaseAuth = Firebase.auth
    private lateinit var userDB: DatabaseReference

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_like)

        userDB = Firebase.database.reference.child("Users")
        val currentUserDB = userDB.child(getCurrentUserID())
        currentUserDB.addListenerForSingleValueEvent(object: ValueEventListener {
            override fun onDataChange(snapshot: DataSnapshot) {
                if (snapshot.child("name").value == null) {
                    showNameInputPopup()
                    return
                }
                // todo 유저정보를 갱신해라.
            }
            override fun onCancelled(error: DatabaseError) {
                TODO("Not yet implemented")
            }
        })
    }

    private fun showNameInputPopup() {
        val editText = EditText(this)

        AlertDialog.Builder(this)
            .setTitle("이름을 입력해주세요.")
            .setView(editText)
            .setPositiveButton("저장") { _, _ ->
                if (editText.text.isEmpty()) {
                    showNameInputPopup()
                } else {
                    saveUserName(editText.text.toString())
                }
            }
            .setCancelable(false)
            .show()
    }

    private fun saveUserName(name: String) {
        val userId = getCurrentUserID()
        val currentUserDB = userDB.child(userId)
        val user = mutableMapOf<String, Any>()
        user["userId"] = userId
        user["name"] = name
        currentUserDB.updateChildren(user)
    }

    private fun getCurrentUserID(): String {
        if (auth.currentUser == null) {
            Toast.makeText(this, "로그인이 되어있지 않습니다.", Toast.LENGTH_SHORT).show()
        }
        return auth.currentUser?.uid.orEmpty()
    }
}
```

Q. addListenerForSingleValueEvent, onDataChange?

A. 



깃허브 CardStackView: <https://github.com/yuyakaido/CardStackView>{:target="_blank"}

**사용방법**

```
dependencies {
    implementation "com.yuyakaido.android:card-stack-view:2.3.4"
}
```

### 에러

- 번호대로 데이터가 넣어지지 않는 경우

**잘못 작성한 경우**

```kotlin
database = Firebase.database.reference.child(n.toString())
button.setOnClickListener{
    val user = mutableMapOf<String, Any>()
    user["title"] = "title" + n.toString()
    user["url"] = "url" + n.toString()
    database.updateChildren(user)
    n++
}
```

**잘 작성한 경우**

```kotlin
button.setOnClickListener{
    database = Firebase.database.reference.child(n.toString())
    val user = mutableMapOf<String, Any>()
    user["title"] = "title" + n.toString()
    user["url"] = "url" + n.toString()
    database.updateChildren(user)
    n++
}
```

> n 이 1씩 증가하는 경우 매번 database 에 새로넣어주어야 한다.

- value 값이 자꾸 null 이 나오는 경우

**잘못 작성한 경우**

```kotlin
val button = findViewById<Button>(R.id.button)
button.setOnClickListener{
    database = Firebase.database.reference.child(n.toString())
    val user = mutableMapOf<String, Any>()
    user["title"] = "title" + n.toString()
    user["url"] = "url" + n.toString()
    database.updateChildren(user)
    n++
}

Firebase.database.reference.child(n.toString()).addChildEventListener(object: ChildEventListener {
    override fun onChildAdded(snapshot: DataSnapshot, previousChildName: String?) {
        val title = snapshot.child("title").value.toString()
        val url = snapshot.child("url").value.toString()
        Log.e("TAG", title)
        Log.e("TAG", url)
    }

```

> 데이터를 저장할 때 (updateChildren) 자식 (child) 를 하나 만들었다고 해서
>
> 불러올 때는 (addChildEventListener) 자식을 넣지 않고 reference 까지만 작성하도록 하면 null 이 나오지 않는다.

**잘 작성한 경우**

```kotlin
val button = findViewById<Button>(R.id.button)
button.setOnClickListener{
    database = Firebase.database.reference.child(n.toString())
    val user = mutableMapOf<String, Any>()
    user["title"] = "title" + n.toString()
    user["url"] = "url" + n.toString()
    database.updateChildren(user)
    n++
}

Firebase.database.reference.addChildEventListener(object: ChildEventListener {
    override fun onChildAdded(snapshot: DataSnapshot, previousChildName: String?) {
        val title = snapshot.child("title").value.toString()
        val url = snapshot.child("url").value.toString()
        Log.e(n.toString(), title)
        Log.e("TAG", url)
    }
```

**전체코드**

```kotlin
class MainActivity : AppCompatActivity() {
    private lateinit var database: DatabaseReference
    private var n = 0

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val button = findViewById<Button>(R.id.button)
        button.setOnClickListener{
            database = Firebase.database.reference.child(n.toString())
            val user = mutableMapOf<String, Any>()
            user["title"] = "title" + n.toString()
            user["url"] = "url" + n.toString()
            database.updateChildren(user)
            n++
        }

        Firebase.database.reference.addChildEventListener(object: ChildEventListener {
            override fun onChildAdded(snapshot: DataSnapshot, previousChildName: String?) {
                val title = snapshot.child("title").value.toString()
                val url = snapshot.child("url").value.toString()
                Log.e("TAG", title)
                Log.e("TAG", url)
            }

            override fun onChildChanged(snapshot: DataSnapshot, previousChildName: String?) {
                //TODO("Not yet implemented")
            }

            override fun onChildRemoved(snapshot: DataSnapshot) {
                //TODO("Not yet implemented")
            }

            override fun onChildMoved(snapshot: DataSnapshot, previousChildName: String?) {
                //TODO("Not yet implemented")
            }

            override fun onCancelled(error: DatabaseError) {
                //TODO("Not yet implemented")
            }
        })
    }
}
```



## 3. 리사이클러 뷰

**리사이클러 뷰 요약**

1. 리사이클러 뷰 추가
2. new Layout 생성
3. new 데이터 클래스 생성
4. new Adapter 클래스 생성
5. 메인클래스 추가

> 어댑터는 리스트객체, 레트로핏은 최상위객체를 입력합니다.

**ListAdapter**

Lia: ListAdapter<데이터, 데이터ItemViewHolder>(diffUtil)

**데이터ItemViewHolder**

inner

(private val binding: Item) : Rec . binding.root

fun bind(데이터: 데이터) {

binding.

**onCreateViewHolder**

return 데이터 Item Layout parent.context, parent, false

**onBindViewHolder**

```kotlin
holder.bind(currentList[position])
```

holder. current [position

**diffUtil** (cdoD)

companion {

val diff = object: D . <데이터>() { -> implement

**areItemsTheSame**

```kotlin
return oldItem == newItem
```

**메인 클래스**

```kotlin
binding = 레이아웃Binding.inflate(layoutInflater)
adapter = 어댑터
setContentView(binding.root)
binding.리사이클러뷰.layoutManager = LinearLayoutManager(this)
binding.리사이클러뷰.adapter = adapter
```

1. 레이아웃
2. binding 후 lateinit
3. 리사이클러뷰
4. 어댑터

**완성된 예제**

**Adapter.kt**

```kotlin
class BookAdapter: ListAdapter<Book, BookAdapter.BookItemViewHolder>(diffUtil) {
    inner class BookItemViewHolder(private val binding: ItemBookBinding): RecyclerView.ViewHolder(binding.root) {
        fun bind(bookModel: Book) {
            binding.titleTextView.text = bookModel.title
        }
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): BookItemViewHolder {
        return BookItemViewHolder(ItemBookBinding.inflate(LayoutInflater.from(parent.context), parent, false))
    }

    override fun onBindViewHolder(holder: BookItemViewHolder, position: Int) {
        holder.bind(currentList[position])
    }

    companion object {
        val diffUtil = object: DiffUtil.ItemCallback<Book>() {
            override fun areItemsTheSame(oldItem: Book, newItem: Book): Boolean {
                return oldItem == newItem
            }

            override fun areContentsTheSame(oldItem: Book, newItem: Book): Boolean {
                return oldItem.id == newItem.id
            }
        }
    }
}
```

**MainActivity.kt**

```kotlin
class MainActivity : AppCompatActivity() {
    private lateinit var adapter: YoutubeAdapter
    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        adapter = YoutubeAdapter()
        setContentView(binding.root)
        binding.recyclerView.layoutManager = LinearLayoutManager(this)
        binding.recyclerView.adapter = adapter
    }
}
```

```kotlin
var list = mutableListOf(
    Video("id1", "title1", "url1", "thumnail1"),
    Video("id2", "title2", "url2", "thumnail2")
)
adapter.submitList(list)

val editText = findViewById<EditText>(R.id.editText)
val button = findViewById<Button>(R.id.button)
button.setOnClickListener{
    list.add(Video("id1", editText.text.toString(), "url1", "thumnail1"))
    adapter.notifyDataSetChanged()
    editText.setText("")
}
```



## 4. 코틀린 네이밍

**xml**

**id**

WHAT\_WHERE_DESCRIPTION

무엇이\_어디에_설명 으로 작성한다.

예) 

- tablayout_main : MainActivity의 TabLayout
- imageview_menu_profile : 커스텀 MenuView의 프로필 이미지
- textview_articledetail_title : ArticleDetailFragment의 title TextView
- imageview_menu_profile
- main_title_tv

예외)

mvp 아키텍처나 바인딩을 사용할 때에는 소문자 카멜

- mainTitle
- submitBtn

메뉴얼: <https://junhyeok830.tistory.com/35>

메뉴얼2: <https://jhy156456.tistory.com/entry/XML-%EB%84%A4%EC%9D%B4%EB%B0%8D%EB%A3%B0>

**kotlin**

**id**

**변수 접두사 축약어**

| **의미** | **접두어** | **예시**   |
| -------- | ---------- | ---------- |
| label    | lbl        | lblText    |
| Button   | btn        | btnNext    |
| Image    | img        | imgTitle   |
| Table    | tbl        | tblStudent |
| Dataset  | ds         | dsBook     |
| Grid     | grd        | grdList    |
| Combo    | cb         | cbCodebook |



## 버튼으로 붙여넣기

```kotlin
/* 클립보드 붙여넣기 버튼 */
var clipboard = getSystemService(Context.CLIPBOARD_SERVICE) as ClipboardManager
imgPost.setOnClickListener {
    if (!clipboard.hasPrimaryClip()) {
        Toast.makeText(this, "복사한 URL 이 없습니다.", Toast.LENGTH_SHORT).show()
    }
    val pasteData = clipboard.primaryClip?.getItemAt(0)?.text as String
    editId.setText(pasteData)
}
```

**함수**

함수는 이상하게 호출에 문제가 있다.

```kotlin
private fun paste(clipboard: ClipboardManager): String {
    if (!clipboard.hasPrimaryClip()) {
        Toast.makeText(this, "복사한 URL 이 없습니다.", Toast.LENGTH_SHORT).show()
    } else {
        val pasteData = clipboard.primaryClip?.getItemAt(0)?.text as String
        return pasteData
    }
}
```

## 리사이클러뷰 내에서 화면전환

**특정 버튼 클릭**

```kotlin
override fun onBindViewHolder(holder: YoutubeItemViewHolder, position: Int) {
    holder.bind(currentList[position])

    /* 유튜브연결 버튼 */
    val imgVideo = holder.itemView.findViewById<ImageView>(R.id.imageview_youtube_video)
    val url = getItem(position).url
    imgVideo.setOnClickListener {
        val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
        startActivity(holder.itemView.context, intent, null)
    }
}
```

**뷰 전체 클릭**

```kotlin
override fun onBindViewHolder(holder: YoutubeItemViewHolder, position: Int) {
    holder.bind(currentList[position])

    /* 유튜브연결 버튼 */
    val url = getItem(position).url
    holder.itemView.setOnClickListener {
        val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
        startActivity(holder.itemView.context, intent, null)
    }
}
```

**위에만 테두리**

```xml
<layer-list xmlns:android="http://schemas.android.com/apk/res/android">
    <item
        android:botton="-2dp"
        android:left="-2dp"
        android:right="-2dp">
        <shape>
            <stroke
                android:color="@color/gray"
                android:width="1dp"/>
            <solid android:color="@color/black"/>
        </shape>
    </item>
</layer-list>
```

