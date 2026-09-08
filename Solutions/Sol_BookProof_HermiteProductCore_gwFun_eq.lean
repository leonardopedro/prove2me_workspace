-- Generated from ChapterHermiteProductCore.lean — solution of BookProof.HermiteProductCore.gwFun_eq
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
import Theorems.Thm_BookProof_HermiteProductCore_gaussWD_eq_sq
open BookProof.HermiteProductCore








open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (r : MvPolynomial (Fin d) ℂ) (x : Vd d) :
    MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) r * (gaussWD x : ℂ) = pgFun r x * pgFun 1 x := by

  simp only [pgFun, gaussWD_eq_sq, map_one]
  push_cast
  ring
