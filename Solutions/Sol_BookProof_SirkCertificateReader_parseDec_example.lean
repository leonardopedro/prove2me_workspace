-- Generated from ChapterSirkCertificateReader.lean — solution of BookProof.SirkCertificateReader.parseDec_example
import Mathlib
import Definitions.Def_ChapterSirkCertificateReader
open BookProof.SirkCertificateReader










open BookProof.SirkCertifiedGap

set_option maxHeartbeats 1000000 in
theorem solution : parseDec "1.9875".toList = some ⟨19875, 4⟩ := by
 rfl
