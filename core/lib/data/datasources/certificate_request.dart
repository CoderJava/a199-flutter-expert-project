import 'dart:io';

import 'package:flutter/services.dart';

class CertificateRequest {
  Future<SecurityContext> get globalContext async {
    final sslCert = await rootBundle.load('certificates/certificate.cer');
    final securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
    return securityContext;
  }
}