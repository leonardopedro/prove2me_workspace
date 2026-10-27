-- Generated from ChapterScalaronHermiteEsa.lean — solution of BookProof.ScalaronHermiteEsa.continuous_expGauss
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
theorem solution (c : ℝ) :
    Continuous fun x : Vd d => ((Real.exp (c * ‖x‖) * gaussD x : ℝ) : ℂ) :=
  Complex.continuous_ofReal.comp
      ((Real.continuous_exp.comp (continuous_const.mul continuous_norm)).mul continuous_gaussD)
