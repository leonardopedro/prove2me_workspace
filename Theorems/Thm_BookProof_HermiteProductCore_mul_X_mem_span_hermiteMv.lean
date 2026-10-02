-- Generated from ChapterHermiteProductCore.lean — theorem BookProof.HermiteProductCore.mul_X_mem_span_hermiteMv
import Definitions.Def_ChapterHermiteFunctions
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore

variable {d : ℕ}



open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section

theorem BookProof.HermiteProductCore.mul_X_mem_span_hermiteMv (i : Fin d) {p : MvPolynomial (Fin d) ℂ}
    (hp : p ∈ Submodule.span ℂ (Set.range (hermiteMv (d := d)))) :
    X i * p ∈ Submodule.span ℂ (Set.range (hermiteMv (d := d))) := by sorry
