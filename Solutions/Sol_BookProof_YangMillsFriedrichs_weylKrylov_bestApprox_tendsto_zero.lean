-- Generated from ChapterYangMillsFriedrichs.lean — solution of BookProof.YangMillsFriedrichs.weylKrylov_bestApprox_tendsto_zero
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichs
import Theorems.Thm_BookProof_ChapterH9_krylov_bestApprox_tendsto_zero
open BookProof.YangMillsFriedrichs




open BookProof.FarisLavine



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution (H : E →ₗ[ℂ] E) (v u : E)
    (hdense : Dense ((⨆ k : ℕ, krylovSpan H v k : Submodule ℂ E) : Set E)) :
    Filter.Tendsto (fun k : ℕ => ‖u - (krylovSpan H v k).starProjection u‖)
      Filter.atTop (nhds 0) := krylov_bestApprox_tendsto_zero H v u hdense
