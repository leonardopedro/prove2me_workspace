-- Generated from ChapterH1.lean — theorem BookProof.ChapterH1.eigenvalue_mem_numericalRange
import Mathlib
import Definitions.Def_ChapterH1
open BookProof.ChapterH1






open scoped BigOperators
open intervalIntegral


noncomputable section














variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

theorem BookProof.ChapterH1.eigenvalue_mem_numericalRange (A : E →ₗ[ℂ] E) (l : ℂ) (v : E)
    (hv : ‖v‖ = 1) (hAv : A v = l • v) : l ∈ numericalRange A := by sorry
