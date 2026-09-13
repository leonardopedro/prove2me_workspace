-- Generated from ChapterYangMillsFriedrichs.lean — solution of BookProof.YangMillsFriedrichs.formNormSq_nonneg
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichs
import Theorems.Thm_BookProof_YangMillsFriedrichs_formNormSq_ge_normSq
import Definitions.Def_ChapterFarisLavine
open BookProof.YangMillsFriedrichs



















open BookProof.FarisLavine




variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution {H : D →ₗ[ℂ] F} (hpos : ∀ x : D, 0 ≤ quadForm H x) (x : D) :
    0 ≤ formNormSq H x := le_trans (by positivity) (formNormSq_ge_normSq hpos x)
