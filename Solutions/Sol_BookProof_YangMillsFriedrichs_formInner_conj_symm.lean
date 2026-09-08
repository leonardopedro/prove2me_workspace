-- Generated from ChapterYangMillsFriedrichs.lean — solution of BookProof.YangMillsFriedrichs.formInner_conj_symm
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.YangMillsFriedrichs



















open BookProof.FarisLavine




variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution {H : D →ₗ[ℂ] F} (hsym : SymmetricOn D H) (x y : D) :
    (starRingEnd ℂ) (formInner H y x) = formInner H x y := by

  simp only [formInner, map_add]
  rw [inner_conj_symm]
  congr 1
  rw [← hsym x y, inner_conj_symm]
