-- Generated from ChapterSirkBandLedger.lean — solution of BookProof.SirkBandLedger.ledger_width_eventually_const
import Mathlib
import Definitions.Def_ChapterSirkBandLedger
import Theorems.Thm_BookProof_SirkBandLedger_recAt_of_ge
import Definitions.Def_ChapterSirkCertificateReader
import Definitions.Def_ChapterBandEnclosure
open BookProof.SirkBandLedger
















open BookProof.SirkCertificateReader
open BookProof.BandEnclosure

set_option maxHeartbeats 1000000 in
theorem solution (L : List BandRecord) {m : ℕ}
    (hm : L.length - 1 ≤ m) :
    ledgerHi L m - ledgerLo L m
      = ledgerHi L (L.length - 1) - ledgerLo L (L.length - 1) := by

  simp [ledgerHi, ledgerLo, hiQ, loQ, recAt_of_ge hm]
