-- Generated from ChapterSirkBandLedger.lean — solution of BookProof.SirkBandLedger.formatExampleLedger_lo_zero
import Mathlib
import Definitions.Def_ChapterSirkBandLedger
open BookProof.SirkBandLedger




open BookProof.SirkCertificateReader
open BookProof.BandEnclosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution : ledgerLo formatExampleLedger 0 = 0.9 := by

  norm_num [ledgerLo, loQ, recAt, formatExampleLedger, Decimal.toQ]
