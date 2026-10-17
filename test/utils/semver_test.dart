import 'package:flutter_test/flutter_test.dart';
import 'package:goodanime/utils/semver.dart';

/// Unit tests for [SemVer] parsing and version comparison operators.
void main() {
  group('SemVer.parse', () {
    test('parses standard major.minor.patch versions', () {
      final version = SemVer.parse('1.2.3');
      expect(version, const SemVer(major: 1, minor: 2, patch: 3));
      expect(version.toString(), '1.2.3');
    });

    test(
      'strips leading v/V prefixes, build metadata (+), and pre-release suffixes (-)',
      () {
        expect(
          SemVer.parse('v0.7.1'),
          const SemVer(major: 0, minor: 7, patch: 1),
        );
        expect(
          SemVer.parse('V2.4.0+15'),
          const SemVer(major: 2, minor: 4, patch: 0),
        );
        expect(
          SemVer.parse('v1.0.0-beta.2+build.42'),
          const SemVer(major: 1, minor: 0, patch: 0),
        );
      },
    );

    test('defaults missing or malformed segments to 0', () {
      expect(SemVer.parse('3.1'), const SemVer(major: 3, minor: 1, patch: 0));
      expect(
        SemVer.parse('invalid'),
        const SemVer(major: 0, minor: 0, patch: 0),
      );
    });
  });

  group('SemVer comparison & upgrade eligibility', () {
    test('orders major, minor, and patch versions accurately', () {
      final v060 = SemVer.parse('0.6.0');
      final v070 = SemVer.parse('0.7.0');
      final v071 = SemVer.parse('0.7.1');
      final v100 = SemVer.parse('1.0.0');

      expect(v070 > v060, isTrue);
      expect(v071 > v070, isTrue);
      expect(v100 > v071, isTrue);
      expect(v060 < v071, isTrue);
      expect(v071 >= SemVer.parse('v0.7.1+15'), isTrue);
      expect(v071 <= SemVer.parse('0.7.1'), isTrue);
      expect(v071 == SemVer.parse('v0.7.1+99'), isTrue);
      expect(v071.hashCode, SemVer.parse('0.7.1').hashCode);
    });
  });
}
