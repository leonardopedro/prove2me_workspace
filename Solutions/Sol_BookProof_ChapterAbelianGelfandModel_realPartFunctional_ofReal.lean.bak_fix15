-- Generated from ChapterAbelianGelfandModel.lean — solution of BookProof.ChapterAbelianGelfandModel.realPartFunctional_ofReal
import Mathlib
import Definitions.Def_ChapterAbelianGelfandModel
open BookProof.ChapterAbelianGelfandModel



open MeasureTheory Complex WeakDual CompactlySupported CompactlySupportedContinuousMap
open scoped ComplexOrder


open BookProof.ChapterLinftyMultiplication

variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]
variable {X : Type*} [TopologicalSpace X]

set_option maxHeartbeats 1000000 in
theorem solution (psi : C(X, ℂ) →ₗ[ℂ] ℂ)
    (hpos : ∀ g : C(X, ℂ), 0 ≤ psi (star g * g)) (f : C(X, ℝ)) :
    psi (toC f) = (realPartFunctional psi f : ℂ) := by

  have hp : (0 : C(X, ℝ)) ≤ f ⊔ 0 := le_sup_right
  have hm : (0 : C(X, ℝ)) ≤ (-f) ⊔ 0 := le_sup_right
  have hsub : toC f = toC (f ⊔ 0) - toC ((-f) ⊔ 0) := by
    ext x
    simp only [toC_apply, ContinuousMap.sub_apply, ContinuousMap.sup_apply,
      ContinuousMap.zero_apply, ContinuousMap.neg_apply]
    rw [← Complex.ofReal_sub]
    congr 1
    rcases le_total (f x) 0 with h | h
    · rw [max_eq_right h, max_eq_left (by linarith)]
      ring
    · rw [max_eq_left h, max_eq_right (by linarith)]
      ring
  have him : (psi (toC f)).im = 0 := by
    rw [hsub, map_sub]
    simp [(psi_nonneg_of_nonneg psi hpos _ hp).2, (psi_nonneg_of_nonneg psi hpos _ hm).2]
  exact Complex.ext (by simp [realPartFunctional]) (by simp [him])
