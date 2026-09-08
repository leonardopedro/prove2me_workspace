-- Generated from ChapterHermiteProductCore.lean — theorem BookProof.HermiteProductCore.span_range_coreBasis
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore







open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

theorem BookProof.HermiteProductCore.span_range_coreBasis (e : ℕ ≃ (Fin d →₀ ℕ)) :
    Submodule.span ℂ (Set.range (coreBasis (d := d) e)) = polyGaussCore (d := d) := by sorry
