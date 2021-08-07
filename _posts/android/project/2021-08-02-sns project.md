---
title: SNS 프로젝트
category: project
---

## 1. 유튜브 API

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

프로젝트 만들기: <https://console.cloud.google.com/projectselector2/apis/credentials?hl=ko&pli=1&supportedpurview=project>{:target="_blank"}

youtube api 라고 검색하고 시작한다.

사용자 인증 정보 탭의 사용자 인증 정보 만들기를 클릭하고 서비스 계정을 클릭한다.











## 썸네일

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

```
/* 파이어베이스 SDK */
implementation platform('com.google.firebase:firebase-bom:28.3.0')
```

기타 다른 라이브러리들을 dependencies 내부에 추가합니다.

다른 라이브러리: <https://firebase.google.com/docs/android/setup#available-libraries>{:target="_blank"}

### **구글 로그인**

1> 앱 수준 build.gradle 파일 dependencies { 내부에 추가

```
/* 구글로그인 인증 */
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

### Realtime Database

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

깃허브 CardStackView: <https://github.com/yuyakaido/CardStackView>{:target="_blank"}

**사용방법**

```
dependencies {
    implementation "com.yuyakaido.android:card-stack-view:2.3.4"
}
```

