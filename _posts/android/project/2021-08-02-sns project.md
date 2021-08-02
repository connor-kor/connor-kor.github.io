---
title: SNS 프로젝트
category: project
---

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

# 1. 유튜브 API

## I. 이미지링크

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