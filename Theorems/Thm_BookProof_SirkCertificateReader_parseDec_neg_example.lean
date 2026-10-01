-- Generated from ChapterSirkCertificateReader.lean — theorem BookProof.SirkCertificateReader.parseDec_neg_example
import Mathlib
import Definitions.Def_ChapterSirkCertificateReader
open BookProof.SirkCertificateReader

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]



open BookProof.SirkCertifiedGap

theorem BookProof.SirkCertificateReader.parseDec_neg_example : parseDec "-0.4231".toList = some ⟨-4231, 4⟩ := by sorry
