-- Generated from ChapterDensitySpectral.lean — theorem BookProof.DensitySpectral.density_iff_exists_unitary_diagonal
import Mathlib
import Definitions.Def_ChapterDensitySpectral
import Definitions.Def_ChapterB4
import Definitions.Def_ChapterDensityMarginalConditional
open BookProof.ChapterB4
open BookProof.DensitySpectral



open Matrix
open scoped BigOperators ComplexOrder

variable {n : Type*} [Fintype n] [DecidableEq n]


theorem BookProof.DensitySpectral.density_iff_exists_unitary_diagonal (ρ : Matrix n n ℂ) :
    IsDensityMatrix ρ ↔
      ∃ (U : Matrix.unitaryGroup n ℂ) (d : n → ℝ),
        (∀ i, 0 ≤ d i) ∧ (∑ i, d i = 1) ∧
        ρ = (U : Matrix n n ℂ) * diagonal (RCLike.ofReal ∘ d) * (U : Matrix n n ℂ)ᴴ := by sorry
