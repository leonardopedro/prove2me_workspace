-- Generated from ChapterScalaronHermiteEsa.lean — solution of BookProof.ScalaronHermiteEsa.norm_expGauss
import Mathlib
import Definitions.Def_ChapterScalaronHermiteEsa
open BookProof.ScalaronHermiteEsa




open MeasureTheory Complex MvPolynomial FourierTransform
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine BookProof.Starobinsky
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (c : ℝ) (x : Vd d) :
    ‖((Real.exp (c * ‖x‖) * gaussD x : ℝ) : ℂ)‖ = Real.exp (c * ‖x‖) * gaussD x := by

  rw [Complex.norm_real, Real.norm_eq_abs,
    abs_of_nonneg (mul_pos (Real.exp_pos _) (gaussD_pos x)).le]
