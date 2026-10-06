-- Generated from ChapterYangMillsFriedrichs.lean — theorem BookProof.YangMillsFriedrichs.weylKrylov_bestApprox_antitone
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterH5
import Definitions.Def_ChapterH9
open BookProof.ChapterH5
open BookProof.ChapterH9
open BookProof.YangMillsFriedrichs

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]



open BookProof.FarisLavine




theorem BookProof.YangMillsFriedrichs.weylKrylov_bestApprox_antitone (H : E →ₗ[ℂ] E) (v : E) {p q : ℕ} (hpq : p ≤ q) (u : E) :
    ‖u - (krylovSpan H v q).starProjection u‖ ≤ ‖u - (krylovSpan H v p).starProjection u‖ := by sorry
