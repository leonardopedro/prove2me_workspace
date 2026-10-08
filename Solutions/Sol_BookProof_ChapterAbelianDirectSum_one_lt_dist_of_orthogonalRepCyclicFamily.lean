-- Generated from ChapterAbelianDirectSum.lean — solution of BookProof.ChapterAbelianDirectSum.one_lt_dist_of_orthogonalRepCyclicFamily
import Mathlib
import Definitions.Def_ChapterAbelianDirectSum
import Theorems.Thm_BookProof_ChapterAbelianDirectSum_inner_eq_zero_of_orthogonalRepCyclicFamily
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
theorem solution {S : Set H}
    (hS : OrthogonalRepCyclicFamily pi S) {x y : H} (hx : x ∈ S) (hy : y ∈ S) (hxy : x ≠ y) :
    1 < dist x y := by

  have h := inner_eq_zero_of_orthogonalRepCyclicFamily hS hx hy hxy
  have hxn : ‖x‖ = 1 := hS.1 x hx
  have hyn : ‖y‖ = 1 := hS.1 y hy
  have hneg : inner ℂ x (-y) = (0 : ℂ) := by simp [h]
  have h2 : ‖x + -y‖ * ‖x + -y‖ = 2 := by
    rw [norm_add_sq_eq_norm_sq_add_norm_sq_of_inner_eq_zero x (-y) hneg, hxn, norm_neg, hyn]
    norm_num
  have hd : dist x y = ‖x + -y‖ := by rw [dist_eq_norm, sub_eq_add_neg]
  nlinarith [norm_nonneg (x + -y), hd, h2]

omit [CompactSpace X] [T2Space X] [MeasurableSpace X] [BorelSpace X] in
