-- Generated from ChapterHermiteProductCore.lean — theorem BookProof.HermiteProductCore.span_hermiteMv
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore







open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

theorem BookProof.HermiteProductCore.span_hermiteMv :
    Submodule.span ℂ (Set.range (hermiteMv (d := d))) = ⊤ := by sorry
