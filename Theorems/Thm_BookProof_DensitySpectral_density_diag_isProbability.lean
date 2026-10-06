-- Generated from ChapterDensityMarginalConditional.lean — theorem BookProof.DensitySpectral.density_diag_isProbability
import Mathlib
import Definitions.Def_ChapterDensityMarginalConditional
import Definitions.Def_ChapterB4
open BookProof.ChapterB4
open BookProof.DensitySpectral

variable {n : Type*} [Fintype n] [DecidableEq n]



open Matrix
open scoped BigOperators ComplexOrder


theorem BookProof.DensitySpectral.density_diag_isProbability {ρ : Matrix n n ℂ} (h : IsDensityMatrix ρ) :
    (∀ i, 0 ≤ (ρ i i).re) ∧ ∑ i, (ρ i i).re = 1 := by sorry
