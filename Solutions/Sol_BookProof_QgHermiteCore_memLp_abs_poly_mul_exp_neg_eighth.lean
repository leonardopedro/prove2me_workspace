-- Generated from ChapterQgHermiteCore.lean — solution of BookProof.QgHermiteCore.memLp_abs_poly_mul_exp_neg_eighth
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
open BookProof.QgHermiteCore














open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky







variable {E : Type*} [NormedAddCommGroup E]

set_option maxHeartbeats 1000000 in
theorem solution (p : Polynomial ℝ) :
    MemLp (fun x : ℝ => ((|p.eval x| * Real.exp (-x ^ 2 / 8) : ℝ) : ℂ)) 2
      (volume : Measure ℝ) := by

  have hmeas : AEStronglyMeasurable
      (fun x : ℝ => ((|p.eval x| * Real.exp (-x ^ 2 / 8) : ℝ) : ℂ)) (volume : Measure ℝ) := by
    refine Continuous.aestronglyMeasurable ?_
    refine Complex.continuous_ofReal.comp ?_
    exact (p.continuous_aeval.abs).mul (by fun_prop)
  rw [memLp_two_iff_integrable_sq_norm hmeas]
  refine (integrable_poly_mul_gaussH (p * p)).congr (Filter.Eventually.of_forall fun x => ?_)
  have hexp : Real.exp (-x ^ 2 / 8) ^ 2 = Real.exp (-x ^ 2 / 4) := by
    rw [sq, ← Real.exp_add]
    congr 1
    ring
  simp only [Polynomial.eval_mul, Complex.norm_real, Real.norm_eq_abs, gaussH]
  rw [abs_of_nonneg (by positivity : (0:ℝ) ≤ |p.eval x| * Real.exp (-x ^ 2 / 8)), mul_pow,
    sq_abs, hexp]
  ring
