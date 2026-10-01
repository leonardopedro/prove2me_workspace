-- Generated from ChapterSirkBandLedger.lean — theorem BookProof.SirkBandLedger.ledgerWf_ne_nil
import Mathlib
import Definitions.Def_ChapterSirkBandLedger
open BookProof.SirkBandLedger

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]



open BookProof.SirkCertificateReader
open BookProof.BandEnclosure

theorem BookProof.SirkBandLedger.ledgerWf_ne_nil {L : List BandRecord} (h : LedgerWf L) : L ≠ [] := by sorry
