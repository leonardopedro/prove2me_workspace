-- Generated from ChapterLorentzRealRep.lean — solution of BookProof.ChapterLorentzRealRep.WHalf_invariant_apply
import Mathlib
import Definitions.Def_ChapterLorentzRealRep
import Theorems.Thm_BookProof_ChapterLorentzRealRep_conjL_apply
import Theorems.Thm_BookProof_ChapterLorentzRealRep_WHalf_invariant
open BookProof.ChapterLorentzRealRep



open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega

set_option maxHeartbeats 1000000 in
theorem solution (S : Matrix (Fin 4) (Fin 4) ℤ) (hS : S ∈ Omega)
    (A : Matrix (Fin 4) (Fin 4) ℝ) (hA : A ∈ WHalf) :
    castR S * A * castR (cinv S) ∈ WHalf := by

  have := WHalf_invariant S hS (Submodule.mem_map_of_mem hA)
  rwa [conjL_apply] at this
