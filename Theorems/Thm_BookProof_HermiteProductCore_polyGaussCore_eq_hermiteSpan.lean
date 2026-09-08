-- Generated from ChapterHermiteProductCore.lean — theorem BookProof.HermiteProductCore.polyGaussCore_eq_hermiteSpan
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore







open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

theorem BookProof.HermiteProductCore.polyGaussCore_eq_hermiteSpan :
    polyGaussCore (d := d)
      = Submodule.span ℂ (Set.range fun a : Fin d →₀ ℕ => pgLp (hermiteMv a)) := by sorry
