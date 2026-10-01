-- Generated from ChapterSirkBandLedger.lean — theorem BookProof.SirkBandLedger.formatExampleLedger_nested
import Definitions.Def_ChapterSirkCertificateReader
import Mathlib
import Definitions.Def_ChapterSirkBandLedger
import Definitions.Def_ChapterBandEnclosure
open BookProof.BandEnclosure
open BookProof.SirkBandLedger

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]



open BookProof.SirkCertificateReader
open BookProof.BandEnclosure

theorem BookProof.SirkBandLedger.formatExampleLedger_nested :
    NestedBands (ledgerLo formatExampleLedger) (ledgerHi formatExampleLedger) := by sorry
