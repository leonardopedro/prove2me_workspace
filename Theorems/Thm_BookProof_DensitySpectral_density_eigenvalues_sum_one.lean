-- Generated from ChapterDensitySpectral.lean — theorem BookProof.DensitySpectral.density_eigenvalues_sum_one
import Mathlib
import Definitions.Def_ChapterDensitySpectral
import Definitions.Def_ChapterB4
import Definitions.Def_ChapterDensityMarginalConditional
open BookProof.ChapterB4
open BookProof.DensitySpectral



open Matrix
open scoped BigOperators ComplexOrder

variable {n : Type*} [Fintype n] [DecidableEq n]


theorem BookProof.DensitySpectral.density_eigenvalues_sum_one {ρ : Matrix n n ℂ} (h : IsDensityMatrix ρ) :
    ∑ i, h.1.eigenvalues i = 1 := by sorry
