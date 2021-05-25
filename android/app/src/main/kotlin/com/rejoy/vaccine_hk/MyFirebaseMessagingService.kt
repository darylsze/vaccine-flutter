package com.rejoy.vaccine_hk

import android.annotation.SuppressLint
import android.util.Log
import com.google.firebase.messaging.FirebaseMessagingService

/**
 * Called if the FCM registration token is updated. This may occur if the security of
 * the previous token had been compromised. Note that this is called when the
 * FCM registration token is initially generated so this is where you would retrieve the token.
 */
class MyFirebaseMessagingService : FirebaseMessagingService() {
    @SuppressLint("LongLogTag")
    override fun onNewToken(newToken: String) {
        super.onNewToken(newToken)
            Log.d("MyFirebaseMessagingService", "Refreshed token: $newToken")
        // If you want to send messages to this application instance or
        // manage this apps subscriptions on the server side, send the
        // FCM registration token to your app server.
        sendRegistrationToServer(newToken)
    }

    private fun sendRegistrationToServer(newToken: String) {

    }
}
