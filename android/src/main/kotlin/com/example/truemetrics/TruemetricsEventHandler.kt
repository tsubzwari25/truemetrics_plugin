package com.example.truemetrics

import android.content.Context
import io.flutter.plugin.common.EventChannel
import io.truemetrics.truemetricssdk.ErrorCode
import io.truemetrics.truemetricssdk.StatusListener
import io.truemetrics.truemetricssdk.TruemetricsSDK
import io.truemetrics.truemetricssdk.engine.permissions.DefaultPermissionsHelper
import io.truemetrics.truemetricssdk.engine.state.State
import io.truemetrics.truemetricssdk.engine.permissions.PermissionsHelper

class TruemetricsEventHandler(private val context: Context) : EventChannel.StreamHandler {

    private var eventSink: EventChannel.EventSink? = null


    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
        TruemetricsSDK.setStatusListener(object : StatusListener {
            override fun onStateChange(state: State) {
                when (state) {
                    State.UNINITIALIZED -> eventSink?.success("UNINITIALIZED")
                    State.INITIALIZED -> {
                        eventSink?.success("INITIALIZED")
                        TruemetricsSDK.startRecording() // Start recording when initialized
                    }
                    State.RECORDING_IN_PROGRESS -> eventSink?.success("RECORDING_IN_PROGRESS")
                    State.RECORDING_STOPPED -> eventSink?.success("RECORDING_STOPPED")
                }
            }

            override fun onError(errorCode: ErrorCode, message: String?) {
                eventSink?.error("ERROR", message, errorCode.toString())
            }

            override fun askPermissions(permissions: List<String>) {
                eventSink?.success("ASK_PERMISSIONS")
            }
        })
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }
}
