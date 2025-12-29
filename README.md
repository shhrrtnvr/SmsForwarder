# SmsForwarder

SmsForwarder is a simple Android application that listens for incoming SMS messages and forwards them to a configured Webhook server.

## Features
- Listens for incoming SMS.
- Forwards SMS content, sender, and receiver information to a Webhook URL in JSON format.
- Extracts OTP codes from SMS messages.
- Supports dual SIM devices.

## How it works
1. The app runs a foreground service to listen for SMS broadcasts.
2. When an SMS is received, it extracts relevant information.
3. It sends a POST request with a JSON payload to the configured Webhook URL.

## JSON Payload Format
```json
{
  "sender": "+1234567890",
  "receiver": "SIM1",
  "content": "Your verification code is 123456",
  "time": "Mon Dec 29 22:07:00 GMT 2025",
  "otp": "123456"
}
```

## Configuration
Currently, the Webhook URL is configured in the source code. You can set your SIM phone numbers in the app's main screen to identify which SIM received the message.

## License
BSD
