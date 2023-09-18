class UrlParser {
  static String githubUsernameDisplay(String url) {
    Uri uri = Uri.parse(url);
    if ((uri.host == 'github.com' || uri.host == 'www.github.com') &&
        uri.pathSegments.isNotEmpty) {
      return uri.pathSegments[0];
    } else {
      return "URL invalida";
    }
  }
}
