-- Generated from ChapterSirkBandLedger.lean — theorem BookProof.SirkBandLedger.recAt_of_ge
import Mathlib
import Definitions.Def_ChapterSirkBandLedger
open BookProof.SirkBandLedger

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]



open BookProof.SirkCertificateReader
open BookProof.BandEnclosure

theorem BookProof.SirkBandLedger.recAt_of_ge {L : List BandRecord} {m : ℕ} (hm : L.length - 1 ≤ m) :
    recAt L m = recAt L (L.length - 1) := by sorry
