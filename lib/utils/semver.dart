/// Represents a semantic version
class SemVer implements Comparable<SemVer> {
  /// Major version component
  final int major;

  /// Minor version component
  final int minor;

  /// Patch version component
  final int patch;

  /// Creates a semantic version
  const SemVer({required this.major, required this.minor, required this.patch});

  /// Parses a semantic version string
  factory SemVer.parse(String version) {
    var cleaned = version.trim();
    if (cleaned.startsWith('v') || cleaned.startsWith('V')) {
      cleaned = cleaned.substring(1);
    }
    final plusIndex = cleaned.indexOf('+');
    if (plusIndex != -1) {
      cleaned = cleaned.substring(0, plusIndex);
    }
    final hyphenIndex = cleaned.indexOf('-');
    if (hyphenIndex != -1) {
      cleaned = cleaned.substring(0, hyphenIndex);
    }
    final parts = cleaned.split('.');
    final major = parts.isNotEmpty ? int.tryParse(parts[0]) ?? 0 : 0;
    final minor = parts.length > 1 ? int.tryParse(parts[1]) ?? 0 : 0;
    final patch = parts.length > 2 ? int.tryParse(parts[2]) ?? 0 : 0;

    return SemVer(major: major, minor: minor, patch: patch);
  }

  /// Compares this version to another version
  @override
  int compareTo(SemVer other) {
    if (major != other.major) return major.compareTo(other.major);
    if (minor != other.minor) return minor.compareTo(other.minor);
    return patch.compareTo(other.patch);
  }

  /// Whether this version is greater than another version
  bool operator >(SemVer other) => compareTo(other) > 0;

  /// Whether this version is greater than or equal to another version
  bool operator >=(SemVer other) => compareTo(other) >= 0;

  /// Whether this version is less than another version
  bool operator <(SemVer other) => compareTo(other) < 0;

  /// Whether this version is less than or equal to another version
  bool operator <=(SemVer other) => compareTo(other) <= 0;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SemVer &&
          runtimeType == other.runtimeType &&
          major == other.major &&
          minor == other.minor &&
          patch == other.patch;

  @override
  int get hashCode => Object.hash(major, minor, patch);

  @override
  String toString() => '$major.$minor.$patch';
}
