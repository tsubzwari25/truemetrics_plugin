package com.example.truemetrics

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlin.test.Test
import org.mockito.Mockito

internal class TruemetricsPluginTest {
  @Test
  fun onMethodCall_getPlatformVersion_returnsExpectedValue() {
    val plugin = TruemetricsPlugin()

    val call = MethodCall("getPlatformVersion", null)
    val mockResult: MethodChannel.Result = Mockito.mock(MethodChannel.Result::class.java)
    plugin.onMethodCall(call, mockResult)

    Mockito.verify(mockResult).success("Android " + android.os.Build.VERSION.RELEASE)
  }
}
