-- Generated from ChapterSirkRitzMinMax.lean — solution of BookProof.RitzMinMax.neg_norm_le_rayleighSup
import Mathlib
import Definitions.Def_ChapterSirkRitzMinMax
import Theorems.Thm_BookProof_RitzMinMax_neg_norm_le_rayleighVal_of_unit
import Theorems.Thm_BookProof_RitzMinMax_rayleighSetOn_bddAbove
import Theorems.Thm_BookProof_RitzMinMax_exists_unit_mem
open BookProof.RitzMinMax










noncomputable section


open BookProof.HermiteGalerkin BookProof.ChapterSirkRitzSpectrum
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (T : F →L[ℂ] F) {S : Submodule ℂ F}
    (hS : 0 < Module.finrank ℂ S) : -‖T‖ ≤ rayleighSup T S := by

  obtain ⟨x, hx, hx1⟩ := exists_unit_mem S hS
  exact (neg_norm_le_rayleighVal_of_unit T hx1).trans
    (le_csSup (rayleighSetOn_bddAbove T S) ⟨x, hx, hx1, rfl⟩)
