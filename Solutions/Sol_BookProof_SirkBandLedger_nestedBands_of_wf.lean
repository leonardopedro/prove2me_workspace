-- Generated from ChapterSirkBandLedger.lean — solution of BookProof.SirkBandLedger.nestedBands_of_wf
import Mathlib
import Definitions.Def_ChapterSirkBandLedger
import Theorems.Thm_BookProof_SirkBandLedger_loQ_monotone
import Theorems.Thm_BookProof_SirkBandLedger_hiQ_antitone
open BookProof.SirkBandLedger
















open BookProof.SirkCertificateReader
open BookProof.BandEnclosure

set_option maxHeartbeats 1000000 in
theorem solution {L : List BandRecord} (h : LedgerWf L) :
    NestedBands (ledgerLo L) (ledgerHi L) := by

  intro m
  refine Set.Icc_subset_Icc ?_ ?_
  · simp only [ledgerLo]
    exact_mod_cast loQ_monotone h (Nat.le_succ m)
  · simp only [ledgerHi]
    exact_mod_cast hiQ_antitone h (Nat.le_succ m)
