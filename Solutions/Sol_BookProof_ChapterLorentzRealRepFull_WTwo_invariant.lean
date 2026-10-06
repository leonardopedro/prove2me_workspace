-- Generated from ChapterLorentzRealRepFull.lean — solution of BookProof.ChapterLorentzRealRepFull.WTwo_invariant
import Mathlib
import Definitions.Def_ChapterLorentzRealRepFull
import Theorems.Thm_BookProof_ChapterLorentzRealRepFull_conj_inv_two
import Theorems.Thm_BookProof_ChapterLorentzRealRepFull_castR_mem_WTwo
import Theorems.Thm_BookProof_ChapterLorentzRealRep_castR_mul
import Theorems.Thm_BookProof_ChapterLorentzRealRep_conjL_apply
open BookProof.ChapterLorentzRealRepFull



open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega BookProof.ChapterLorentzRealRep
open BookProof.ChapterLorentzRealRepSum
open Module

set_option maxHeartbeats 1000000 in
theorem solution (S : Matrix (Fin 4) (Fin 4) ℤ) (hS : S ∈ Omega) :
    WTwo.map (conjL (castR S) (castR (cinv S))) ≤ WTwo := by

  apply Submodule.map_le_iff_le_comap.mpr
  refine Submodule.span_le.mpr ?_
  rintro _ ⟨i, rfl⟩
  simp only [w2R, conjL_apply, Submodule.mem_comap, SetLike.mem_coe]
  convert castR_mem_WTwo _ (conj_inv_two S hS i) using 1
  simp [castR_mul]
