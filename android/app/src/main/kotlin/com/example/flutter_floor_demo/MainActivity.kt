package com.example.flutter_floor_demo

import android.os.Bundle
import android.widget.Toast
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {

    private val channel = "samples.flutter.dev/toast"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        //super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler { call, result ->

            if (call.method == "toast"){
                showToast("Inserted!")
            }
            else if (call.method == "delete"){
                showToast("All Values Deleted!")
            }
            else{
                result.notImplemented()
            }

        }
    }

    private fun showToast(msg: String){
        Toast.makeText(this@MainActivity, msg, Toast.LENGTH_SHORT).show()
    }

}
