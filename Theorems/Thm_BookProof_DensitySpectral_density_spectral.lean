-- Generated from ChapterDensitySpectral.lean — theorem BookProof.DensitySpectral.density_spectral
import Mathlib
import Definitions.Def_ChapterDensitySpectral
import Definitions.Def_ChapterB4
import Definitions.Def_ChapterDensityMarginalConditional
open BookProof.ChapterB4
open BookProof.DensitySpectral



open Matrix
open scoped BigOperators ComplexOrder

variable {n : Type*} [Fintype n] [DecidableEq n]


theorem BookProof.DensitySpectral.density_spectral {ρ : Matrix n n ℂ} (h : IsDensityMatrix ρ) :
    ρ = (h.1.eigenvectorUnitary : Matrix n n ℂ)
        * diagonal (RCLike.ofReal ∘ h.1.eigenvalues)
        * (h.1.eigenvectorUnitary : Matrix n n ℂ)ᴴ := by sorry
