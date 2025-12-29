package com.idormy.sms.forwarder.utils.sender

import android.Manifest
import android.os.Build
import androidx.annotation.RequiresApi
import androidx.annotation.RequiresPermission
import com.idormy.sms.forwarder.App
import com.idormy.sms.forwarder.entity.MsgInfo
import com.idormy.sms.forwarder.utils.Log
import com.idormy.sms.forwarder.utils.PhoneUtils
import com.idormy.sms.forwarder.utils.SettingUtils

class SmsUtils {
    companion object {
        private val TAG: String = SmsUtils::class.java.simpleName

        @RequiresApi(Build.VERSION_CODES.LOLLIPOP_MR1)
        @RequiresPermission(Manifest.permission.READ_PHONE_STATE)
        fun sendMsg(msgInfo: MsgInfo) {
            val mobile = SettingUtils.fallbackSmsPhone
            if (mobile.isEmpty()) return

            val content = "From: ${msgInfo.from}\nContent: ${msgInfo.content}"
            
            if (App.SimInfoList.isEmpty()) {
                App.SimInfoList = PhoneUtils.getSimMultiInfo()
            }
            
            val mSubscriptionId: Int = if (App.SimInfoList.isNotEmpty()) {
                App.SimInfoList.values.firstOrNull()?.mSubscriptionId ?: -1
            } else -1
            
            val res = PhoneUtils.sendSms(mSubscriptionId, mobile, content)
            if (res == null) {
                Log.d(TAG, "SMS sent successfully")
            } else {
                Log.e(TAG, "Failed to send SMS: $res")
            }
        }
    }
}
