-- Generated from ChapterHermiteProductCore.lean — solution of BookProof.HermiteProductCore.gaussWD_eq_sq
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore




open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
nctions` by Fubini. -/

/-- The Gaussian weight `e^{-‖x‖²/2} = :=
   (e^{-‖x‖²/4})²`. -/
  def gaussWD (x : Vd d) : ℝ := Real.exp (-‖x‖ ^ 2 / 2)
  
  theorem gaussWD_eq_sq (x : Vd d) : gaussWD x = gaussD x * gaussD x := by
    rw [
