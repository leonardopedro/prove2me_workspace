-- Generated from ChapterDensitySpectral.lean — theorem BookProof.DensitySpectral.density_eigenvalues_nonneg
import Mathlib
import Definitions.Def_ChapterDensitySpectral
import Definitions.Def_ChapterB4
import Definitions.Def_ChapterDensityMarginalConditional
open BookProof.ChapterB4
open BookProof.DensitySpectral

variable {n : Type*} [Fintype n] [DecidableEq n]



open Matrix
open scoped BigOperators ComplexOrder


theorem BookProof.DensitySpectral.density_eigenvalues_nonneg {ρ : Matrix n n ℂ} (h : IsDensityMatrix ρ) (i : n) :
    0 ≤ h.1.eigenvalues i := by sorry
