-- Generated from ChapterYangMillsFriedrichs.lean — theorem BookProof.YangMillsFriedrichs.weylKrylov_bestApprox_tendsto_zero
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




theorem BookProof.YangMillsFriedrichs.weylKrylov_bestApprox_tendsto_zero (H : E →ₗ[ℂ] E) (v u : E)
    (hdense : Dense ((⨆ k : ℕ, krylovSpan H v k : Submodule ℂ E) : Set E)) :
    Filter.Tendsto (fun k : ℕ => ‖u - (krylovSpan H v k).starProjection u‖)
      Filter.atTop (nhds 0) := by sorry
