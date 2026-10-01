-- Generated from ChapterSirkBandLedger.lean — theorem BookProof.SirkBandLedger.ledgerLo_le_ledgerHi
import Mathlib
import Definitions.Def_ChapterSirkBandLedger
open BookProof.SirkBandLedger

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]



open BookProof.SirkCertificateReader
open BookProof.BandEnclosure

theorem BookProof.SirkBandLedger.ledgerLo_le_ledgerHi {L : List BandRecord} (h : LedgerWf L) (m : ℕ) :
    ledgerLo L m ≤ ledgerHi L m := by sorry
