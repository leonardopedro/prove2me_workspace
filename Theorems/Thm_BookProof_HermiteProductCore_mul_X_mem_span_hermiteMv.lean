-- Generated from ChapterHermiteProductCore.lean — theorem BookProof.HermiteProductCore.mul_X_mem_span_hermiteMv
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore







open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

theorem BookProof.HermiteProductCore.mul_X_mem_span_hermiteMv (i : Fin d) {p : MvPolynomial (Fin d) ℂ}
    (hp : p ∈ Submodule.span ℂ (Set.range (hermiteMv (d := d)))) :
    X i * p ∈ Submodule.span ℂ (Set.range (hermiteMv (d := d))) := by sorry
