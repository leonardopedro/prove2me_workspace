-- Generated from ChapterYangMillsFriedrichsLimit.lean — solution of BookProof.YangMillsFriedrichsLimit.krylov_starProjection_tendsto
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichsLimit
import Theorems.Thm_BookProof_ChapterH9_krylov_bestApprox_tendsto_zero
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterH5
import Definitions.Def_ChapterH9
open BookProof.YangMillsFriedrichsLimit




open BookProof.FarisLavine BookProof.YangMillsFriedrichs

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
open BookProof.ChapterH5 BookProof.ChapterH9
theorem solution (A : F →L[ℂ] F) (v : F)
    (hdense : Dense ((⨆ n : ℕ, krylovSpan A.toLinearMap v n : Submodule ℂ F) : Set F)) (u : F) :
    Filter.Tendsto (fun n : ℕ => (krylovSpan A.toLinearMap v n).starProjection u)
      Filter.atTop (nhds u) := by
    have h := krylov_bestApprox_tendsto_zero A.toLinearMap v u hdense
    rw [tendsto_iff_norm_sub_tendsto_zero]
    simpa [norm_sub_rev] usin
