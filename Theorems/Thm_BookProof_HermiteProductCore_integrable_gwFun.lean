-- Generated from ChapterHermiteProductCore.lean — theorem BookProof.HermiteProductCore.integrable_gwFun
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore







open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

theorem BookProof.HermiteProductCore.integrable_gwFun (r : MvPolynomial (Fin d) ℂ) :
    Integrable (fun x : Vd d =>
      MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) r * (gaussWD x : ℂ)) := by sorry
