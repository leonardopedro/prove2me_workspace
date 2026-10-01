-- Generated from ChapterSirkCertificateReader.lean — theorem BookProof.SirkCertificateReader.parseDec_example
import Definitions.Def_ChapterSirkCertifiedGap
import Mathlib
import Definitions.Def_ChapterSirkCertificateReader
import Definitions.Def_ChapterSirkBandLedger
open BookProof.SirkBandLedger
open BookProof.SirkCertificateReader



open BookProof.SirkCertifiedGap

theorem BookProof.SirkCertificateReader.parseDec_example : parseDec "1.9875".toList = some ⟨19875, 4⟩ := by sorry
