package com.example.truemetrics

import android.content.Context

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.EventChannel
import io.truemetrics.truemetricssdk.TruemetricsSDK
import io.truemetrics.truemetricssdk.engine.TruemetricEngine
import io.truemetrics.truemetricssdk.engine.storage.db.SensorStats

/** TruemetricsPlugin */
class TruemetricsPlugin: FlutterPlugin {

  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var methodChannel : MethodChannel
  private lateinit var eventChannel: EventChannel
  private lateinit var truemetricsMethodHandler: TruemetricsMethodHandler
  private lateinit var truemetricsEventHandler: TruemetricsEventHandler
  private lateinit var truemetricsMethods: TruemetricsMethods


  private lateinit var context:Context

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    setupChannels(flutterPluginBinding)

  }

  fun  setupChannels(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding){
    truemetricsMethods = TruemetricsMethods();
    methodChannel = MethodChannel(flutterPluginBinding.binaryMessenger, "truemetrics")
    eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "truemetrics_events")
    context = flutterPluginBinding.applicationContext
    truemetricsMethodHandler = TruemetricsMethodHandler()
    truemetricsEventHandler = TruemetricsEventHandler(context)
    truemetricsMethodHandler.init(context,truemetricsMethods)
    methodChannel.setMethodCallHandler(truemetricsMethodHandler);
    eventChannel.setStreamHandler(truemetricsEventHandler)
  }


  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    // Clean up channels and handlers when detached
    methodChannel.setMethodCallHandler(null)
    eventChannel.setStreamHandler(null)
  }
}
