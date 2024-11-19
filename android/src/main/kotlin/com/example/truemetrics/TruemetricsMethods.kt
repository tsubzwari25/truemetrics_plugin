package com.example.truemetrics

import android.content.Context
import io.truemetrics.truemetricssdk.TruemetricsSDK
import io.truemetrics.truemetricssdk.config.Config
import io.truemetrics.truemetricssdk.engine.storage.db.SensorStats
import java.util.Objects


class TruemetricsMethods() {



    fun init(context: Context, newApiKey:String): String{
        var deviceID:String =  TruemetricsSDK.initialize(context, Config(apiKey= newApiKey));
        return deviceID
    }

    fun startRecording():String {
        if(TruemetricsSDK.isInitialized()){
            TruemetricsSDK.startRecording()
            val sensorStats: List<SensorStats> = TruemetricsSDK.getSensorStats()
            return sensorStats.toString()
        }else{
            return "Error"
        }
    }

    fun stopRecording(){
        TruemetricsSDK.stopRecording()
    }

    fun deinit (){
        TruemetricsSDK.deinitialize()
    }

    fun logMetadeta (data: Map<String, String> ){
        TruemetricsSDK.logMetadata(data);
    }

}