-- Generated from ChapterHermiteProductCore.lean — theorem BookProof.HermiteProductCore.span_hermiteMv
import Definitions.Def_ChapterHermiteFunctions
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore

variable {d : ℕ}



open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section

theorem BookProof.HermiteProductCore.span_hermiteMv :
    Submodule.span ℂ (Set.range (hermiteMv (d := d))) = ⊤ := by sorry
