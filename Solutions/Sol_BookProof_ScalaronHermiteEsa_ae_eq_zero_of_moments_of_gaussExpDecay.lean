-- Generated from ChapterScalaronHermiteEsa.lean — solution of BookProof.ScalaronHermiteEsa.ae_eq_zero_of_moments_of_gaussExpDecay
import Mathlib
import Definitions.Def_ChapterScalaronHermiteEsa
import Theorems.Thm_BookProof_ScalaronHermiteEsa_fourier_gaussD_mul_eq_zero_of_gaussExpDecay
open BookProof.ScalaronHermiteEsa




open MeasureTheory Complex MvPolynomial FourierTransform
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine BookProof.Starobinsky
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {u : Vd d → ℂ} (hu : GaussExpDecay u)
    (hmom : ∀ p : MvPolynomial (Fin d) ℂ, ∫ x : Vd d, pgFun p x * u x = 0) :
    ∀ᵐ x : Vd d, u x = 0 := by

  have hv : Integrable (fun x : Vd d => ((gaussD x : ℝ) : ℂ) * u x) := by
    have h0 := hu 0
    simpa only [zero_mul, Real.exp_zero, one_mul] using h0
  have hzero := ae_eq_zero_of_fourier_eq_zero hv
    (fun w => fourier_gaussD_mul_eq_zero_of_gaussExpDecay hu hmom w)
  filter_upwards [hzero] with x hx
  have hne : ((gaussD x : ℝ) : ℂ) ≠ 0 := by
    exact_mod_cast ne_of_gt (gaussD_pos x)
  exact (mul_eq_zero.mp hx).resolve_left hne
