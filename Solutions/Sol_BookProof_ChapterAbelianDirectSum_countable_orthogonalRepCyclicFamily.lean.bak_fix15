-- Generated from ChapterAbelianDirectSum.lean — solution of BookProof.ChapterAbelianDirectSum.countable_orthogonalRepCyclicFamily
import Mathlib
import Definitions.Def_ChapterAbelianDirectSum
import Theorems.Thm_BookProof_ChapterAbelianDirectSum_one_lt_dist_of_orthogonalRepCyclicFamily
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
theorem solution [TopologicalSpace.SeparableSpace H] {S : Set H}
    (hS : OrthogonalRepCyclicFamily pi S) : S.Countable := by

  refine Set.PairwiseDisjoint.countable_of_isOpen (s := fun x : H => Metric.ball x (1 / 2)) ?_
    (fun x _ => Metric.isOpen_ball) (fun x _ => ⟨x, Metric.mem_ball_self (by norm_num)⟩)
  intro x hx y hy hxy
  refine Metric.ball_disjoint_ball ?_
  have := one_lt_dist_of_orthogonalRepCyclicFamily hS hx hy hxy
  linarith
