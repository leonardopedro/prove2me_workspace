-- Generated from ChapterHermiteProductCore.lean — theorem BookProof.HermiteProductCore.span_range_coreBasis
import Definitions.Def_ChapterHermiteFunctions
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore

variable {d : ℕ}



open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section

theorem BookProof.HermiteProductCore.span_range_coreBasis (e : ℕ ≃ (Fin d →₀ ℕ)) :
    Submodule.span ℂ (Set.range (coreBasis (d := d) e)) = polyGaussCore (d := d) := by sorry
