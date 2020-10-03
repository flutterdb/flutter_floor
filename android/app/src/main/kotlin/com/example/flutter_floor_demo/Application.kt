package com.example.flutter_floor_demo

import com.tekartik.sqflite.SqflitePlugin
import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry

class Application : FlutterApplication(), PluginRegistry.PluginRegistrantCallback {

    override fun onCreate() {
        super.onCreate()
    }

    override fun registerWith(registry: PluginRegistry?) {
        //add SqflitePlugin plugin register  if you work with sqflite
        SqflitePlugin.registerWith(registry!!.registrarFor("com.tekartik.sqflite.SqflitePlugin"))
    }
}