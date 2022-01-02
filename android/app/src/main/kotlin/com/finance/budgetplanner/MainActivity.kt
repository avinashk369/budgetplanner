package com.finance.budgetplanner

import android.content.Intent
import android.os.Build
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

class MainActivity: FlutterActivity() {
    lateinit var intent:Any
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // TODO: Register the ListTileNativeAdFactory
        // GoogleMobileAdsPlugin.registerNativeAdFactory(
        //         flutterEngine, "listTile", ListTileNativeAdFactory(context))
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        super.cleanUpFlutterEngine(flutterEngine)

        // TODO: Unregister the ListTileNativeAdFactory
        //GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTile")
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger,"com.finance.budgetplanner")
                .setMethodCallHandler{call,result->

                    if(call.method=="startService")
                    {
                        startService()
                    }
                }

    }

    fun startService()
    {
        intent=Intent(this,AppService::class.java)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            startForegroundService(intent as Intent)
        }else
        {
            startService(intent as Intent)
        }
    }
}