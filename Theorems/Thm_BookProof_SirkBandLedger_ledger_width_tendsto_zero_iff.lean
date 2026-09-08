-- Generated from ChapterSirkBandLedger.lean — theorem BookProof.SirkBandLedger.ledger_width_tendsto_zero_iff
import Mathlib
import Definitions.Def_ChapterSirkBandLedger
open BookProof.SirkBandLedger















open BookProof.SirkCertificateReader
open BookProof.BandEnclosure

theorem BookProof.SirkBandLedger.ledger_width_tendsto_zero_iff (L : List BandRecord) :
    Filter.Tendsto (fun m => ledgerHi L m - ledgerLo L m) Filter.atTop (nhds 0) ↔
      ledgerHi L (L.length - 1) - ledgerLo L (L.length - 1) = 0 := by sorry
