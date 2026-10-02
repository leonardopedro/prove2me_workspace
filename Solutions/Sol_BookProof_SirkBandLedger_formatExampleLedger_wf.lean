-- Generated from ChapterSirkBandLedger.lean — solution of BookProof.SirkBandLedger.formatExampleLedger_wf
import Mathlib
import Definitions.Def_ChapterSirkBandLedger
open BookProof.SirkBandLedger




open BookProof.SirkCertificateReader
open BookProof.BandEnclosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution : LedgerWf formatExampleLedger := by
 decide
