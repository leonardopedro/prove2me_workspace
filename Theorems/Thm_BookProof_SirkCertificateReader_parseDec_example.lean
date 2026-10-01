-- Generated from ChapterSirkCertificateReader.lean — theorem BookProof.SirkCertificateReader.parseDec_example
import Mathlib
import Definitions.Def_ChapterSirkCertificateReader
open BookProof.SirkCertificateReader

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]



open BookProof.SirkCertifiedGap

theorem BookProof.SirkCertificateReader.parseDec_example : parseDec "1.9875".toList = some ⟨19875, 4⟩ := by sorry
