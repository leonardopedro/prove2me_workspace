-- Generated from ChapterSirkCertificateReader.lean — solution of BookProof.SirkCertificateReader.formatExample_width
import Mathlib
import Definitions.Def_ChapterSirkCertificateReader
open BookProof.SirkCertificateReader




open BookProof.SirkCertifiedGap

set_option maxHeartbeats 1000000 in
theorem solution : formatExampleData.widthQ = 555 / 10000 := by

  norm_num [CertificateData.widthQ, formatExampleData, Decimal.toQ]
