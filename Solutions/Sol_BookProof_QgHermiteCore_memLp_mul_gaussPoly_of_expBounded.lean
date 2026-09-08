-- Generated from ChapterQgHermiteCore.lean — solution of BookProof.QgHermiteCore.memLp_mul_gaussPoly_of_expBounded
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
import Theorems.Thm_BookProof_QgHermiteCore_exp_abs_mul_gaussH_le
import Theorems.Thm_BookProof_QgHermiteCore_ExpBounded_nonneg_const
import Theorems.Thm_BookProof_QgHermiteCore_continuous_gaussPoly
import Theorems.Thm_BookProof_QgHermiteCore_memLp_abs_poly_mul_exp_neg_eighth
open BookProof.QgHermiteCore














open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky







variable {E : Type*} [NormedAddCommGroup E]

set_option maxHeartbeats 1000000 in
theorem solution {W : ℝ → ℝ} (hW : Continuous W)
    (hWb : ExpBounded W) (p : Polynomial ℝ) :
    MemLp (fun x : ℝ => ((W x * gaussPoly p x : ℝ) : ℂ)) 2 (volume : Measure ℝ) := by

  obtain ⟨C, c, -, hbound0⟩ := hWb
  have hC : 0 ≤ C := ExpBounded.nonneg_const hbound0
  have hbound : ∀ y : ℝ, |W y| ≤ C * Real.exp (c * |y|) := by
    simpa [Real.norm_eq_abs] using hbound0
  set K : ℝ := C * Real.exp (2 * c ^ 2) with hK
  have hKnn : 0 ≤ K := by positivity
  have hg : MemLp (fun x : ℝ => ((K : ℂ) * ((|p.eval x| * Real.exp (-x ^ 2 / 8) : ℝ) : ℂ))) 2
      (volume : Measure ℝ) := (memLp_abs_poly_mul_exp_neg_eighth p).const_mul _
  refine hg.of_le ?_ (Filter.Eventually.of_forall fun x => ?_)
  · refine Continuous.aestronglyMeasurable ?_
    exact Complex.continuous_ofReal.comp (hW.mul (continuous_gaussPoly p))
  · have hgH : 0 < gaussH x := gaussH_pos x
    have h1 : |W x * gaussPoly p x| ≤ (C * Real.exp (c * |x|)) * (|p.eval x| * gaussH x) := by
      rw [gaussPoly, abs_mul, abs_mul, abs_of_pos hgH]
      have := hbound x
      have h2 : (0:ℝ) ≤ |p.eval x| * gaussH x := by positivity
      calc |W x| * (|p.eval x| * gaussH x)
          ≤ (C * Real.exp (c * |x|)) * (|p.eval x| * gaussH x) :=
            mul_le_mul_of_nonneg_right this h2
        _ = (C * Real.exp (c * |x|)) * (|p.eval x| * gaussH x) := rfl
    have h3 : Real.exp (c * |x|) * gaussH x ≤ Real.exp (2 * c ^ 2) * Real.exp (-x ^ 2 / 8) :=
      exp_abs_mul_gaussH_le c x
    have h4 : (C * Real.exp (c * |x|)) * (|p.eval x| * gaussH x)
        ≤ K * (|p.eval x| * Real.exp (-x ^ 2 / 8)) := by
      have hp : (0:ℝ) ≤ |p.eval x| := abs_nonneg _
      have hstep : C * |p.eval x| * (Real.exp (c * |x|) * gaussH x)
          ≤ C * |p.eval x| * (Real.exp (2 * c ^ 2) * Real.exp (-x ^ 2 / 8)) :=
        mul_le_mul_of_nonneg_left h3 (by positivity)
      calc (C * Real.exp (c * |x|)) * (|p.eval x| * gaussH x)
          = C * |p.eval x| * (Real.exp (c * |x|) * gaussH x) := by ring
        _ ≤ C * |p.eval x| * (Real.exp (2 * c ^ 2) * Real.exp (-x ^ 2 / 8)) := hstep
        _ = K * (|p.eval x| * Real.exp (-x ^ 2 / 8)) := by rw [hK]; ring
    have hnormf : ‖((W x * gaussPoly p x : ℝ) : ℂ)‖ = |W x * gaussPoly p x| := by
      simp [Complex.norm_real]
    have hnormg : ‖((K : ℂ) * ((|p.eval x| * Real.exp (-x ^ 2 / 8) : ℝ) : ℂ))‖
        = K * (|p.eval x| * Real.exp (-x ^ 2 / 8)) := by
      rw [norm_mul, Complex.norm_real, Complex.norm_real, Real.norm_eq_abs, Real.norm_eq_abs,
        abs_of_nonneg hKnn,
        abs_of_nonneg (by positivity : (0:ℝ) ≤ |p.eval x| * Real.exp (-x ^ 2 / 8))]
    rw [hnormf, hnormg]
    linarith
