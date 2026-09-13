-- Generated from ChapterSirkCertificateReader.lean — solution of BookProof.SirkCertificateReader.formatExample_gap
import Mathlib
import Definitions.Def_ChapterSirkCertificateReader
import Definitions.Def_ChapterSirkCertifiedGap
open BookProof.SirkCertificateReader










open BookProof.SirkCertifiedGap




































variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution : formatExampleData.gapQ = 19875 / 10000 := by

  norm_num [CertificateData.gapQ, formatExampleData, Decimal.toQ]
