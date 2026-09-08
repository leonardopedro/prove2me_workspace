-- Generated from ChapterSirkCertificateReader.lean — solution of BookProof.SirkCertificateReader.parseDec_neg_example
import Mathlib
import Definitions.Def_ChapterSirkCertificateReader
open BookProof.SirkCertificateReader










open BookProof.SirkCertifiedGap

set_option maxHeartbeats 1000000 in
theorem solution : parseDec "-0.4231".toList = some ⟨-4231, 4⟩ := by
 rfl
