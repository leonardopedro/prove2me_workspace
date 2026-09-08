-- Generated from ChapterSirkBandLedger.lean — solution of BookProof.SirkBandLedger.ledgerWf_order
import Mathlib
import Definitions.Def_ChapterSirkBandLedger
open BookProof.SirkBandLedger
















open BookProof.SirkCertificateReader
open BookProof.BandEnclosure

set_option maxHeartbeats 1000000 in
theorem solution {L : List BandRecord} (h : LedgerWf L) {i : ℕ}
    (hi : i < L.length) : (L.getD i default).order = i := by

  rw [LedgerWf, ledgerWfB] at h
  simp only [Bool.and_eq_true, List.all_eq_true, List.mem_range, beq_iff_eq] at h
  exact h.1.1.2 i hi
