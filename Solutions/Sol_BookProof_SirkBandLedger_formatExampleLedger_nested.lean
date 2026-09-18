-- Generated from ChapterSirkBandLedger.lean — solution of BookProof.SirkBandLedger.formatExampleLedger_nested
import Mathlib
import Definitions.Def_ChapterSirkBandLedger
import Theorems.Thm_BookProof_SirkBandLedger_nestedBands_of_wf
import Theorems.Thm_BookProof_SirkBandLedger_formatExampleLedger_wf
open BookProof.SirkBandLedger




open BookProof.SirkCertificateReader
open BookProof.BandEnclosure

set_option maxHeartbeats 1000000 in
theorem solution :
    NestedBands (ledgerLo formatExampleLedger) (ledgerHi formatExampleLedger) := nestedBands_of_wf formatExampleLedger_wf
