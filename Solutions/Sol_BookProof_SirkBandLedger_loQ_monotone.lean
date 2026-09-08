-- Generated from ChapterSirkBandLedger.lean — solution of BookProof.SirkBandLedger.loQ_monotone
import Mathlib
import Definitions.Def_ChapterSirkBandLedger
import Theorems.Thm_BookProof_SirkBandLedger_ledgerWf_step
import Theorems.Thm_BookProof_SirkBandLedger_recAt_of_ge
import Theorems.Thm_BookProof_SirkBandLedger_recAt_of_lt
open BookProof.SirkBandLedger
















open BookProof.SirkCertificateReader
open BookProof.BandEnclosure

set_option maxHeartbeats 1000000 in
theorem solution {L : List BandRecord} (h : LedgerWf L) : Monotone (loQ L) := by

  refine monotone_nat_of_le_succ (fun m => ?_)
  simp only [loQ]
  by_cases hm : m + 1 < L.length
  · rw [recAt_of_lt (show m < L.length by omega), recAt_of_lt hm]
    exact (ledgerWf_step h hm).1
  · rw [recAt_of_ge (show L.length - 1 ≤ m by omega),
      recAt_of_ge (show L.length - 1 ≤ m + 1 by omega)]
