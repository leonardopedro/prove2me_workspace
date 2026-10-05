-- Generated from ChapterAbelianDirectSum.lean — solution of BookProof.ChapterAbelianDirectSum.starProjection_commutes_rep
import Mathlib
import Definitions.Def_ChapterAbelianDirectSum
import Theorems.Thm_BookProof_ChapterAbelianDirectSum_repInvariant_orthogonal
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
theorem solution {M : Submodule ℂ H} [M.HasOrthogonalProjection]
    (hM : RepInvariant pi M) (g : C(X, ℂ)) (v : H) :
    M.starProjection (pi g v) = pi g (M.starProjection v) := by

  refine Submodule.eq_starProjection_of_mem_orthogonal'
    (hM g _ (M.starProjection_apply_mem v))
    (repInvariant_orthogonal pi hM g _ (M.sub_starProjection_mem_orthogonal v)) ?_
  rw [← map_add]
  congr 1
  abel
