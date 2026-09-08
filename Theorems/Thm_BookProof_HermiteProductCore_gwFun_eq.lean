-- Generated from ChapterHermiteProductCore.lean — theorem BookProof.HermiteProductCore.gwFun_eq
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore







open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

theorem BookProof.HermiteProductCore.gwFun_eq (r : MvPolynomial (Fin d) ℂ) (x : Vd d) :
    MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) r * (gaussWD x : ℂ) = pgFun r x * pgFun 1 x := by sorry
