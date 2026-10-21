-- Generated from ChapterAbelianDirectSum.lean — solution of BookProof.ChapterAbelianDirectSum.inner_eq_zero_of_orthogonalRepCyclicFamily
import Mathlib
import Definitions.Def_ChapterAbelianDirectSum
import Theorems.Thm_BookProof_ChapterAbelianDirectSum_self_mem_repCyclicSubspace
import Theorems.Thm_BookProof_ChapterAbelianDirectSum_inner_eq_zero_of_le_orthogonal
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
variable (xi : H)
variable {pi}
variable (pi)

set_option maxHeartbeats 1000000 in
omit [CompactSpace X] [T2Space X] [MeasurableSpace X] [BorelSpace X] in
theorem solution {S : Set H}
    (hS : OrthogonalRepCyclicFamily pi S) {x y : H} (hx : x ∈ S) (hy : y ∈ S) (hxy : x ≠ y) :
    inner ℂ x y = (0 : ℂ) :=
  inner_eq_zero_of_le_orthogonal (hS.2 x hx y hy hxy) (self_mem_repCyclicSubspace pi x)
      (self_mem_repCyclicSubspace pi y)
