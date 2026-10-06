-- Generated from ChapterScalaronHermiteEsa.lean — solution of BookProof.ScalaronHermiteEsa.potCore_deficiencyTrivialAt
import Mathlib
import Definitions.Def_ChapterScalaronHermiteEsa
import Theorems.Thm_BookProof_ScalaronHermiteEsa_ae_eq_zero_of_moments_of_gaussExpDecay
import Theorems.Thm_BookProof_ScalaronHermiteEsa_gaussExpDecay_potential_sub
import Theorems.Thm_BookProof_ScalaronHermiteEsa_moments_of_deficiency
open BookProof.ScalaronHermiteEsa




open MeasureTheory Complex MvPolynomial FourierTransform
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine BookProof.Starobinsky
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {W : Vd d → ℝ} (hWc : Continuous W) (hWb : ExpBounded W)
    {z : ℂ} (hz : z.im ≠ 0) :
    DeficiencyTrivialAt (polyGaussCore (d := d)) (potCore W hWc hWb) z := by

  intro w hw
  have hu := gaussExpDecay_potential_sub hWc hWb z w
  have hzero := ae_eq_zero_of_moments_of_gaussExpDecay hu
    (moments_of_deficiency hWc hWb hw)
  refine Lp.eq_zero_iff_ae_eq_zero.mpr ?_
  filter_upwards [hzero] with x hx
  have hne : ((W x : ℝ) : ℂ) - z ≠ 0 := by
    intro h
    apply hz
    have : (((W x : ℝ) : ℂ) - z).im = 0 := by rw [h]; simp
    simpa using this
  exact (mul_eq_zero.mp hx).resolve_left hne
