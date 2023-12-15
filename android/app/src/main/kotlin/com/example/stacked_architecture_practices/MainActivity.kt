package com.example.petfinder

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Context
import android.os.Build
import android.os.Bundle
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter

import android.os.Build.VERSION
import android.os.Build.VERSION_CODES

class MainActivity: FlutterActivity() {
  private val CHANNEL = "com.rasityilmaz.osversion"

  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
  // This method is invoked on the main thread.
  call, result ->
  if (call.method == "getOsVersion") {
    val osVersion = getOsVersion()

    
      result.success(osVersion)
    
  } else {
    result.notImplemented()
  }
}

    
  }




  private fun getOsVersion(): String {
  val osVersion: String
  osVersion = "${Build.VERSION.SDK_INT}"
  return osVersion
  }
}