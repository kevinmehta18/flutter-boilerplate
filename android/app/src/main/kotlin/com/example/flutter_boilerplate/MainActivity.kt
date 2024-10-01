package com.example.flutter_boilerplate

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel 

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity(){
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "examplechannelname").setMethodCallHandler { call, result ->
            when (call.method) {
                "methodName" -> {
                    // Handle the method invocation and returns the result
                    val payload = intent.extras?.getString("payload") // payload is the actual key used in your notification for passing data
                    // Pass the payload to Flutter
                    val response = payload ?: ""
                    result.success(response)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}
