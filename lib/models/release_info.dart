/// Represents release metadata from GitHub
class ReleaseInfo {
  /// Tag name of the release
  final String tagName;

  /// GitHub web URL of the release
  final String htmlUrl;

  /// Direct APK download URL if present in release assets
  final String? apkDownloadUrl;

  /// Creates release metadata
  const ReleaseInfo({
    required this.tagName,
    required this.htmlUrl,
    this.apkDownloadUrl,
  });

  /// Creates release metadata from GitHub release JSON map
  factory ReleaseInfo.fromJson(Map<String, dynamic> json) {
    final tagName = json['tag_name'] as String? ?? '';
    final htmlUrl = json['html_url'] as String? ?? '';

    String? apkUrl;
    final assets = json['assets'] as List<dynamic>?;
    if (assets != null) {
      for (final asset in assets) {
        if (asset is Map<String, dynamic>) {
          final name = asset['name'] as String? ?? '';
          if (name.endsWith('.apk')) {
            apkUrl = asset['browser_download_url'] as String?;
            break;
          }
        }
      }
    }

    return ReleaseInfo(
      tagName: tagName,
      htmlUrl: htmlUrl,
      apkDownloadUrl: apkUrl,
    );
  }
}
