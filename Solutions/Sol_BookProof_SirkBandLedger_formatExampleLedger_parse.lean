-- Generated from ChapterSirkBandLedger.lean — solution of BookProof.SirkBandLedger.formatExampleLedger_parse
import Mathlib
import Definitions.Def_ChapterSirkBandLedger
open BookProof.SirkBandLedger




open BookProof.SirkCertificateReader
open BookProof.BandEnclosure

set_option maxHeartbeats 1000000 in
theorem solution :
    parseLedger formatExampleLedgerNdjson = formatExampleLedger := by
 rfl
