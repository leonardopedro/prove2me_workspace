-- Generated from ChapterAbelianDirectSum.lean — solution of BookProof.ChapterAbelianDirectSum.commute_starProjection_rep
import Mathlib
import Definitions.Def_ChapterAbelianDirectSum
import Theorems.Thm_BookProof_ChapterAbelianDirectSum_starProjection_commutes_rep
open BookProof.ChapterAbelianDirectSum



noncomputable section

open MeasureTheory Complex WeakDual


open BookProof.ChapterAbelianGelfandModel BookProof.ChapterAbelianCyclicModel

variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (pi : C(X, ℂ) →⋆ₐ[ℂ] (H →L[ℂ] H))

variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (pi : C(X, ℂ) →⋆ₐ[ℂ] (H →L[ℂ] H))

set_option maxHeartbeats 1000000 in
omit [CompactSpace X] [T2Space X] [MeasurableSpace X] [BorelSpace X] in
theorem solution {M : Submodule ℂ H} [M.HasOrthogonalProjection]
    (hM : RepInvariant pi M) (g : C(X, ℂ)) :
    Commute M.starProjection (pi g) := by

  ext v
  simpa [ContinuousLinearMap.mul_apply] using starProjection_commutes_rep pi hM g v
