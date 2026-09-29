-- Generated from ChapterQgHermiteCore.lean — solution of BookProof.QgHermiteCore.integrable_potential_gaussPoly_mul
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
import Theorems.Thm_BookProof_QgHermiteCore_exp_abs_mul_gaussH_le
import Theorems.Thm_BookProof_QgHermiteCore_ExpBounded_nonneg_const
import Theorems.Thm_BookProof_QgHermiteCore_continuous_gaussPoly
import Theorems.Thm_BookProof_QgHermiteCore_ExpBounded_const_mul
import Theorems.Thm_BookProof_HermiteCore_integrable_poly_mul_gaussH
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterHermiteFunctions
open BookProof.QgHermiteCore














open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky







variable {E : Type*} [NormedAddCommGroup E]

set_option maxHeartbeats 1000000 in
theorem solution {W : ℝ → ℝ} (hW : Continuous W)
    (hWb : ExpBounded W) (p q : Polynomial ℝ) :
    Integrable (fun x : ℝ => W x * (gaussPoly p x * gaussPoly q x)) := by

  obtain ⟨C, c, -, hb0⟩ := hWb
  have hC : 0 ≤ C := ExpBounded.nonneg_const hb0
  have hb : ∀ y : ℝ, |W y| ≤ C * Real.exp (c * |y|) := by
    simpa [Real.norm_eq_abs] using hb0
  set K : ℝ := C * Real.exp (2 * c ^ 2) with hK
  have hmaj : Integrable (fun x : ℝ => K * |(p * q).eval x * gaussH x|) :=
    ((integrable_poly_mul_gaussH (p * q)).abs).const_mul K
  refine hmaj.mono' ((hW.mul ((continuous_gaussPoly p).mul
    (continuous_gaussPoly q))).aestronglyMeasurable) (Filter.Eventually.of_forall fun x => ?_)
  have hgH : 0 < gaussH x := gaussH_pos x
  have hstep : Real.exp (c * |x|) * gaussH x ≤ Real.exp (2 * c ^ 2) * Real.exp (-x ^ 2 / 8) :=
    exp_abs_mul_gaussH_le c x
  have he8 : Real.exp (-x ^ 2 / 8) ≤ 1 := by
    rw [Real.exp_le_one_iff]
    nlinarith [sq_nonneg x]
  have hlhs : ‖W x * (gaussPoly p x * gaussPoly q x)‖
      = |W x| * (|(p * q).eval x| * (gaussH x * gaussH x)) := by
    simp only [gaussPoly, Real.norm_eq_abs, Polynomial.eval_mul, abs_mul, abs_of_pos hgH]
    ring
  have hrhs : K * |(p * q).eval x * gaussH x| = K * (|(p * q).eval x| * gaussH x) := by
    rw [abs_mul, abs_of_pos hgH]
  rw [hlhs, hrhs]
  have hnn : (0:ℝ) ≤ |(p * q).eval x| * gaussH x := by positivity
  have h1 : |W x| * (|(p * q).eval x| * (gaussH x * gaussH x))
      ≤ (C * Real.exp (c * |x|)) * (|(p * q).eval x| * (gaussH x * gaussH x)) := by
    have hnn2 : (0:ℝ) ≤ |(p * q).eval x| * (gaussH x * gaussH x) := by positivity
    exact mul_le_mul_of_nonneg_right (hb x) hnn2
  have h2 : (C * Real.exp (c * |x|)) * (|(p * q).eval x| * (gaussH x * gaussH x))
      = C * (Real.exp (c * |x|) * gaussH x) * (|(p * q).eval x| * gaussH x) := by ring
  have h3 : C * (Real.exp (c * |x|) * gaussH x) * (|(p * q).eval x| * gaussH x)
      ≤ C * (Real.exp (2 * c ^ 2) * Real.exp (-x ^ 2 / 8)) * (|(p * q).eval x| * gaussH x) :=
    mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_left hstep hC) hnn
  have h5 : Real.exp (2 * c ^ 2) * Real.exp (-x ^ 2 / 8) ≤ Real.exp (2 * c ^ 2) := by
    nlinarith [Real.exp_pos (2 * c ^ 2), he8]
  have h4 : C * (Real.exp (2 * c ^ 2) * Real.exp (-x ^ 2 / 8)) * (|(p * q).eval x| * gaussH x)
      ≤ K * (|(p * q).eval x| * gaussH x) :=
    mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_left h5 hC) hnn
  linarith
