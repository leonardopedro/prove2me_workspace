-- Generated from ChapterSirkBandLedger.lean — theorem BookProof.SirkBandLedger.ledgerWf_step
import Mathlib
import Definitions.Def_ChapterSirkBandLedger
open BookProof.SirkBandLedger

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]



open BookProof.SirkCertificateReader
open BookProof.BandEnclosure

theorem BookProof.SirkBandLedger.ledgerWf_step {L : List BandRecord} (h : LedgerWf L) {i : ℕ}
    (hi : i + 1 < L.length) :
    (L.getD i default).lo.toQ ≤ (L.getD (i + 1) default).lo.toQ ∧
      (L.getD (i + 1) default).hi.toQ ≤ (L.getD i default).hi.toQ := by sorry
