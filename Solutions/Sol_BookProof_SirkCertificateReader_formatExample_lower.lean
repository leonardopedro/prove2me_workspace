-- Generated from ChapterSirkCertificateReader.lean — solution of BookProof.SirkCertificateReader.formatExample_lower
import Mathlib
import Definitions.Def_ChapterSirkCertificateReader
import Theorems.Thm_BookProof_SirkCertificateReader_formatExample_parse
import Definitions.Def_ChapterSirkCertifiedGap
open BookProof.SirkCertificateReader










open BookProof.SirkCertifiedGap




































variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution : ndjsonLower formatExampleNdjson = some (1932 / 1000) := by

  rw [ndjsonLower, formatExample_parse]
  norm_num [CertificateData.lowerQ, CertificateData.gapQ, CertificateData.widthQ,
    formatExampleData, Decimal.toQ]
