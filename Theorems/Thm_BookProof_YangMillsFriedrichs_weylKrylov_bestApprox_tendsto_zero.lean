-- Generated from ChapterYangMillsFriedrichs.lean — theorem BookProof.YangMillsFriedrichs.weylKrylov_bestApprox_tendsto_zero
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.YangMillsFriedrichs



open BookProof.FarisLavine



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

theorem BookProof.YangMillsFriedrichs.weylKrylov_bestApprox_tendsto_zero (H : E →ₗ[ℂ] E) (v u : E)
    (hdense : Dense ((⨆ k : ℕ, krylovSpan H v k : Submodule ℂ E) : Set E)) :
    Filter.Tendsto (fun k : ℕ => ‖u - (krylovSpan H v k).starProjection u‖)
      Filter.atTop (nhds 0) := by sorry
