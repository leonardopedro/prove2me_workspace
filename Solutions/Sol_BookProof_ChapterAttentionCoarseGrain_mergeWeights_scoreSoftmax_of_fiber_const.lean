-- Generated from ChapterAttentionCoarseGrain.lean — solution of BookProof.ChapterAttentionCoarseGrain.mergeWeights_scoreSoftmax_of_fiber_const
import Mathlib
import Definitions.Def_ChapterAttentionCoarseGrain
open BookProof.ChapterAttentionCoarseGrain



open scoped BigOperators

noncomputable section


open BookProof.ChapterObservableExpectation BookProof.ChapterSoftmaxSharpness

variable {m r : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m r : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (f : Fin m → Fin r)
    (t : Fin r → ℝ) (y : Fin r) :
    mergeWeights f (scoreSoftmax beta (fun x => t (f x))) y
      = ((Finset.univ.filter (fun x => f x = y)).card : ℝ) * Real.exp (beta * t y)
        / ∑ z, ((Finset.univ.filter (fun x => f x = z)).card : ℝ) * Real.exp (beta * t z) := by

  have hden : ∑ x, Real.exp (beta * t (f x))
      = ∑ z, ((Finset.univ.filter (fun x => f x = z)).card : ℝ) * Real.exp (beta * t z) := by
    refine ((Finset.sum_fiberwise Finset.univ f (fun x => Real.exp (beta * t (f x)))).symm).trans ?_
    refine Finset.sum_congr rfl fun z _ => ?_
    rw [Finset.sum_congr rfl (fun x hx => by rw [(Finset.mem_filter.mp hx).2] :
      ∀ x ∈ Finset.univ.filter (fun x => f x = z),
        Real.exp (beta * t (f x)) = Real.exp (beta * t z))]
    simp [mul_comm]
  rw [mergeWeights]
  rw [Finset.sum_congr rfl (fun x hx => by rw [scoreSoftmax, (Finset.mem_filter.mp hx).2] :
    ∀ x ∈ Finset.univ.filter (fun x => f x = y),
      scoreSoftmax beta (fun x => t (f x)) x
        = Real.exp (beta * t y) / ∑ x, Real.exp (beta * t (f x)))]
  rw [Finset.sum_const, hden, nsmul_eq_mul, ← mul_div_assoc]
