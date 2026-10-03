-- Generated from ChapterH9.lean — theorem BookProof.ChapterH9.krylov_bestApprox_tendsto_zero
import Definitions.Def_ChapterH1
import Definitions.Def_ChapterH4
import Definitions.Def_ChapterH6
import Definitions.Def_ChapterH8
import Mathlib
import Definitions.Def_ChapterH9
import Definitions.Def_ChapterH5
open BookProof.ChapterH5
open BookProof.ChapterH9

variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


noncomputable section


open BookProof.ChapterH1 BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6
open BookProof.ChapterH8
open ContinuousLinearMap



theorem BookProof.ChapterH9.krylov_bestApprox_tendsto_zero (H : E →ₗ[ℂ] E) (v u : E)
    (hdense : Dense ((⨆ n : ℕ, krylovSpan H v n : Submodule ℂ E) : Set E)) :
    Filter.Tendsto (fun n : ℕ => ‖u - (krylovSpan H v n).starProjection u‖)
      Filter.atTop (nhds 0) := by sorry
