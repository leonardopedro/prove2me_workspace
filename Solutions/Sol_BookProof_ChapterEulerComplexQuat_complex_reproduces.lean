-- Generated from ChapterEulerComplexQuat.lean — solution of BookProof.ChapterEulerComplexQuat.complex_reproduces
import Mathlib
import Definitions.Def_ChapterEulerComplexQuat
open BookProof.ChapterEulerComplexQuat



open scoped Quaternion BigOperators


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (p : Fin n → ℝ) (hp0 : ∀ k, 0 ≤ p k)
    (hp1 : ∑ k, p k = 1) :
    ∃ v : Fin n → ℂ, (∑ k, Complex.normSq (v k) = 1) ∧ ∀ k, cbornProb v k = p k := by

  refine ⟨fun k => (Real.sqrt (p k) : ℂ), ?_, ?_⟩
  · rw [← hp1]
    refine Finset.sum_congr rfl (fun k _ => ?_)
    rw [Complex.normSq_ofReal, Real.mul_self_sqrt (hp0 k)]
  · intro k
    rw [cbornProb, Complex.normSq_ofReal, Real.mul_self_sqrt (hp0 k)]
