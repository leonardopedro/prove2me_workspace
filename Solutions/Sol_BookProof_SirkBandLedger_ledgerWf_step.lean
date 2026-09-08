-- Generated from ChapterSirkBandLedger.lean — solution of BookProof.SirkBandLedger.ledgerWf_step
import Mathlib
import Definitions.Def_ChapterSirkBandLedger
import Theorems.Thm_BookProof_SirkBandLedger_Decimal_leB_iff
open BookProof.SirkBandLedger
















open BookProof.SirkCertificateReader
open BookProof.BandEnclosure

set_option maxHeartbeats 1000000 in
theorem solution {L : List BandRecord} (h : LedgerWf L) {i : ℕ}
    (hi : i + 1 < L.length) :
    (L.getD i default).lo.toQ ≤ (L.getD (i + 1) default).lo.toQ ∧
      (L.getD (i + 1) default).hi.toQ ≤ (L.getD i default).hi.toQ := by

  rw [LedgerWf, ledgerWfB] at h
  simp only [Bool.and_eq_true, List.all_eq_true, List.mem_range, decide_eq_true_eq] at h
  have hmem : i < L.length - 1 := by omega
  obtain ⟨h1, h2⟩ := h.1.2 i hmem
  exact ⟨(Decimal.leB_iff _ _).1 h1, (Decimal.leB_iff _ _).1 h2⟩
