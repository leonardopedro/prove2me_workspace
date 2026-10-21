-- Generated from ChapterLorentzRealRep.lean — solution of BookProof.ChapterLorentzRealRep.WHalf_invariant
import Mathlib
import Definitions.Def_ChapterLorentzRealRep
import Theorems.Thm_BookProof_ChapterLorentzRealRep_conj_inv_half
import Theorems.Thm_BookProof_ChapterLorentzRealRep_castR_mul
import Theorems.Thm_BookProof_ChapterLorentzRealRep_conjL_apply
import Theorems.Thm_BookProof_ChapterLorentzRealRep_castR_mem_WHalf
open BookProof.ChapterLorentzRealRep



open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega

set_option maxHeartbeats 1000000 in
theorem solution (S : Matrix (Fin 4) (Fin 4) ℤ) (hS : S ∈ Omega) :
    WHalf.map (conjL (castR S) (castR (cinv S))) ≤ WHalf := by

  apply Submodule.map_le_iff_le_comap.mpr;
  refine Submodule.span_le.mpr ?_;
  rintro _ ⟨ i, rfl ⟩;
  simp only [Submodule.comap_coe, bHalfR, Set.mem_preimage, conjL_apply, SetLike.mem_coe];
  rw [ ← castR_mul, ← castR_mul ];
  exact castR_mem_WHalf _ ( conj_inv_half S hS i )
