-- Generated from ChapterSirkBandLedger.lean — solution of BookProof.SirkBandLedger.ledger_width_tendsto_zero_iff
import Mathlib
import Definitions.Def_ChapterSirkBandLedger
import Theorems.Thm_BookProof_SirkBandLedger_ledger_width_eventually_const
import Definitions.Def_ChapterSirkCertificateReader
import Definitions.Def_ChapterBandEnclosure
open BookProof.SirkBandLedger
















open BookProof.SirkCertificateReader
open BookProof.BandEnclosure

set_option maxHeartbeats 1000000 in
theorem solution (L : List BandRecord) :
    Filter.Tendsto (fun m => ledgerHi L m - ledgerLo L m) Filter.atTop (nhds 0) ↔
      ledgerHi L (L.length - 1) - ledgerLo L (L.length - 1) = 0 := by

  have hev : (fun m => ledgerHi L m - ledgerLo L m) =ᶠ[Filter.atTop]
      (fun _ => ledgerHi L (L.length - 1) - ledgerLo L (L.length - 1)) := by
    filter_upwards [Filter.eventually_ge_atTop (L.length - 1)] with m hm
    exact ledger_width_eventually_const L hm
  rw [Filter.tendsto_congr' hev]
  exact tendsto_const_nhds_iff
