package com.example.truemetrics

import android.app.Notification
import android.content.Context
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.truemetrics.truemetricssdk.TruemetricsSDK
import io.truemetrics.truemetricssdk.config.Config


class TruemetricsMethodHandler : MethodCallHandler {
    private lateinit var context:Context
    private lateinit var  apiKey: String
    private lateinit var  truemetrics:TruemetricsMethods

    fun init(newContext:Context, truemetricsMethods: TruemetricsMethods){
        context = newContext
        truemetrics = truemetricsMethods

    }


    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "init" -> {
                apiKey = call.arguments as String
                result.success(truemetrics.init(context, apiKey))
            }
            "startRecording" -> {
                var sensorStats: String = truemetrics.startRecording()
                result.success("Sensor Data $sensorStats")
            }
            "stopRecording"-> {
                truemetrics.stopRecording()
            }
            "deinit" -> {
                truemetrics.deinit();
            } "log"->{
                var logs:Map<String, String> = call.arguments as Map<String,String>
                truemetrics.logMetadeta(data = logs);
            }
            else -> {
                result.notImplemented()
            }
        }
    }
}