-- Generated from ChapterDegSchrodingerCore.lean — solution of BookProof.DegSchrodinger.expBounded_polyW
import Mathlib
import Definitions.Def_ChapterDegSchrodingerCore
import Theorems.Thm_BookProof_DegSchrodinger_abs_coord_le_norm
import Theorems.Thm_BookProof_QgHermiteCore_ExpBounded_nonneg_const
open BookProof.DegSchrodinger




open MeasureTheory SchwartzMap MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.HermiteProductBasis

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (q : MvPolynomial (Fin d) ℂ) : ExpBounded (polyW q) := by

  induction q using MvPolynomial.induction_on with
  | C a =>
      refine ⟨‖a‖, 0, le_rfl, fun x => ?_⟩
      have hC : polyW (C a : MvPolynomial (Fin d) ℂ) x = a.re := by simp [polyW]
      rw [hC]
      simpa using Complex.abs_re_le_norm a
  | add p q hp hq =>
      obtain ⟨C1, c1, hc1, h1⟩ := hp
      obtain ⟨C2, c2, hc2, h2⟩ := hq
      have hC1 : 0 ≤ C1 := ExpBounded.nonneg_const h1
      have hC2 : 0 ≤ C2 := ExpBounded.nonneg_const h2
      refine ⟨C1 + C2, max c1 c2, le_trans hc1 (le_max_left _ _), fun x => ?_⟩
      have hadd : polyW (p + q) x = polyW p x + polyW q x := by simp [polyW]
      have e1 : C1 * Real.exp (c1 * ‖x‖) ≤ C1 * Real.exp (max c1 c2 * ‖x‖) :=
        mul_le_mul_of_nonneg_left (Real.exp_le_exp.mpr
          (mul_le_mul_of_nonneg_right (le_max_left _ _) (norm_nonneg x))) hC1
      have e2 : C2 * Real.exp (c2 * ‖x‖) ≤ C2 * Real.exp (max c1 c2 * ‖x‖) :=
        mul_le_mul_of_nonneg_left (Real.exp_le_exp.mpr
          (mul_le_mul_of_nonneg_right (le_max_right _ _) (norm_nonneg x))) hC2
      rw [hadd]
      have h1x := h1 x
      have h2x := h2 x
      have htri := abs_add_le (polyW p x) (polyW q x)
      linarith
  | mul_X p i hp =>
      obtain ⟨C1, c1, hc1, h1⟩ := hp
      have hC1 : 0 ≤ C1 := ExpBounded.nonneg_const h1
      refine ⟨C1, c1 + 1, by linarith, fun x => ?_⟩
      have hmul : polyW (p * X i) x = polyW p x * (x i) := by
        simp only [polyW, map_mul, MvPolynomial.eval_X, Complex.mul_re, Complex.ofReal_re,
          Complex.ofReal_im, mul_zero, sub_zero]
      rw [hmul, abs_mul]
      have hxi : |x i| ≤ ‖x‖ := abs_coord_le_norm x i
      have hexp : ‖x‖ ≤ Real.exp ‖x‖ := (Real.add_one_le_exp ‖x‖).trans' (by linarith)
      have hstep : |polyW p x| * |x i| ≤ (C1 * Real.exp (c1 * ‖x‖)) * Real.exp ‖x‖ := by
        refine mul_le_mul (h1 x) (hxi.trans hexp) (abs_nonneg _) ?_
        positivity
      refine hstep.trans (le_of_eq ?_)
      rw [mul_assoc, ← Real.exp_add]
      ring_nf
