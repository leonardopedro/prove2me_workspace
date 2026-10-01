-- Generated from ChapterYangMillsFriedrichs.lean — theorem BookProof.YangMillsFriedrichs.form_closable
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavineCore
open BookProof.YangMillsFriedrichs

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}



open BookProof.FarisLavine




theorem BookProof.YangMillsFriedrichs.form_closable {H : D →ₗ[ℂ] F} (hsym : SymmetricOn D H)
    (hpos : ∀ x : D, 0 ≤ quadForm H x) (x : ℕ → D)
    (hCauchy : ∀ ε > 0, ∃ N : ℕ, ∀ p ≥ N, ∀ q ≥ N, formNormSq H (x p - x q) < ε)
    (hzero : Filter.Tendsto (fun n => ((x n : F))) Filter.atTop (nhds 0)) :
    Filter.Tendsto (fun n => formNormSq H (x n)) Filter.atTop (nhds 0) := by sorry
