import 'dart:io';

class LinkedInSession {

  final authorizationEndpoint = Uri.parse("http://example.com/oauth2/authorization");
  final tokenEndpoint = Uri.parse("http://example.com/oauth2/token");
  final identifier = "my client identifier";
  final secret = "my client secret";
  final redirectUrl = Uri.parse("http://my-site.com/oauth2-redirect");
  final credentialsFile = new File("oauth2/credentials.json");

}