-- Generated from ChapterSirkBandLedger.lean — theorem BookProof.SirkBandLedger.recAt_of_lt
import Mathlib
import Definitions.Def_ChapterSirkBandLedger
open BookProof.SirkBandLedger

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]



open BookProof.SirkCertificateReader
open BookProof.BandEnclosure

theorem BookProof.SirkBandLedger.recAt_of_lt {L : List BandRecord} {m : ℕ} (hm : m < L.length) :
    recAt L m = L.getD m default := by sorry
