-- Generated from ChapterYangMillsFriedrichsLimit.lean — theorem BookProof.YangMillsFriedrichsLimit.krylov_starProjection_tendsto
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterYangMillsFriedrichs
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichsLimit
import Definitions.Def_ChapterH5
import Definitions.Def_ChapterH9
open BookProof.ChapterH5
open BookProof.ChapterH9
open BookProof.YangMillsFriedrichsLimit



open BookProof.FarisLavine BookProof.YangMillsFriedrichs

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

theorem BookProof.YangMillsFriedrichsLimit.krylov_starProjection_tendsto (A : F →L[ℂ] F) (v : F)
    (hdense : Dense ((⨆ n : ℕ, krylovSpan A.toLinearMap v n : Submodule ℂ F) : Set F)) (u : F) :
    Filter.Tendsto (fun n : ℕ => (krylovSpan A.toLinearMap v n).starProjection u)
      Filter.atTop (nhds u) := by sorry
