-- Generated from ChapterHermiteProductCore.lean — theorem BookProof.HermiteProductCore.polyGaussCore_eq_hermiteSpan
import Definitions.Def_ChapterHermiteFunctions
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore

variable {d : ℕ}



open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section

theorem BookProof.HermiteProductCore.polyGaussCore_eq_hermiteSpan :
    polyGaussCore (d := d)
      = Submodule.span ℂ (Set.range fun a : Fin d →₀ ℕ => pgLp (hermiteMv a)) := by sorry
