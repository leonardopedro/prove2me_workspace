-- Generated from ChapterSirkBandLedger.lean — solution of BookProof.SirkBandLedger.ledgerLo_le_ledgerHi
import Mathlib
import Definitions.Def_ChapterSirkBandLedger
import Theorems.Thm_BookProof_SirkBandLedger_ledgerWf_ne_nil
import Theorems.Thm_BookProof_SirkBandLedger_ledgerWf_enclosing
import Definitions.Def_ChapterSirkCertificateReader
import Definitions.Def_ChapterBandEnclosure
open BookProof.SirkBandLedger
















open BookProof.SirkCertificateReader
open BookProof.BandEnclosure

set_option maxHeartbeats 1000000 in
theorem solution {L : List BandRecord} (h : LedgerWf L) (m : ℕ) :
    ledgerLo L m ≤ ledgerHi L m := by

  have hne := ledgerWf_ne_nil h
  have hlen : 0 < L.length := List.length_pos_iff.mpr hne
  have hlt : min m (L.length - 1) < L.length := lt_of_le_of_lt (min_le_right _ _) (by omega)
  have hmem : recAt L m ∈ L := by
    simp only [recAt, List.getD_eq_getElem?_getD, List.getElem?_eq_getElem hlt]
    exact List.getElem_mem hlt
  have hle := ledgerWf_enclosing h hmem
  simp only [ledgerLo, ledgerHi, loQ, hiQ]
  exact_mod_cast hle
