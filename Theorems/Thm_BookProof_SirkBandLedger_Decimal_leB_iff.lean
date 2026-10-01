-- Generated from ChapterSirkBandLedger.lean — theorem BookProof.SirkBandLedger.Decimal.leB_iff
import Mathlib
import Definitions.Def_ChapterSirkBandLedger
open BookProof.SirkBandLedger
open BookProof.SirkBandLedger.Decimal

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]



open BookProof.SirkCertificateReader
open BookProof.BandEnclosure

theorem BookProof.SirkBandLedger.Decimal.leB_iff (d e : Decimal) : Decimal.leB d e ↔ d.toQ ≤ e.toQ := by sorry
