//dummy function
String getTokenFromGoogleId(String uid) {
  final Map<String, String> tokens = {
    "ruY8f7BoUZVeZTDjbThBsrMWVp43" : "rwXvl7IzPpzMtm9t+YsGSHDyL5xa7StbwH7RsksFg8dpATO8lnPji8vWtH7ROq2ohOT/u1b6Rnr2KEYg1oDXKipO4zJBTHMj0RLfSgEgrKG9PMqCQ+LA/2MUro5pke4EMnYwuLFx2vKe7lvBAmE9nzwlUqS1xfO9t6Sd+GwM1OQ=#logon40004",
    "5gz6xmT7arWqNEqcZ5BwhJgqTD23" : "9WWfXeiwNxC+GjNBmu8pBeh+9m8xNJ4Y3kqLKKQG0ecFxpL3RScXlm2bZqVec32JBrzc79SdEiU0Hd4SQOCNk26ivxHC0dNA1TlWBnFfLTC3oOz/LYasSr8xR3YITI09IZH/mef7mq4qSQtEJo4PI6NWWBM1D5z711Gcpv5wEg4=#logon40004",
  };
  return tokens[uid] ?? "Ejn1gDjBm6TTpnARK45Rq34UJ3hUEIr5WTP6+1pZ++o18teWZiPvt7fW3tCuoffGplj/bHMCXz4y9te+PaKfBk8qm90ax5yLkJpTMBNMRq0MdJNktFwXAESLbZxpLWA0cV2KctaiLtEYfu5y4GNdoZW/OeztEuBUEAd7IZ4Ow0c=#logon40004";
}

Map<String, dynamic> getAccountOptions(String email) {
  final Map<String, Map<String, dynamic>> options = {
    "ahrenrsf@gmail.com" : {
      "Phone Number" : "+17788761234",
      "Email Receipts" : false,
      "Reservation Reminders" : true,
      "Weekly Newsletter" : true,
    },
    "ahrens21@brocktonschool.com" : {
      "Phone Number" : "+16048893403",
      "Email Receipts" : true,
      "Reservation Reminders" : false,
      "Weekly Newsletter" : true,
    },
  };
  return options[email] ?? {
    "Phone Number" : "+1604999999",
    "Email Receipts" : true,
    "Reservation Reminders" : false,
    "Weekly Newsletter" : false,
  };
}