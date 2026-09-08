-- Generated from ChapterQgHermiteCore.lean — solution of BookProof.QgHermiteCore.expBounded_pow
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
open BookProof.QgHermiteCore














open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky







variable {E : Type*} [NormedAddCommGroup E]

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) : ExpBounded (fun x : ℝ => x ^ k) := by

  refine ⟨(k.factorial : ℝ), 1, zero_le_one, fun x => ?_⟩
  rw [Real.norm_eq_abs]
  have hfac : (0 : ℝ) < (k.factorial : ℝ) := by positivity
  have h := Real.pow_div_factorial_le_exp |x| (abs_nonneg x) k
  rw [div_le_iff₀ hfac] at h
  rw [abs_pow, one_mul]
  linarith [h]
