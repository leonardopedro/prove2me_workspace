-- Generated from ChapterDensityMarginalConditional.lean — theorem BookProof.DensitySpectral.density_marginal_conditional
import Mathlib
import Definitions.Def_ChapterDensityMarginalConditional
import Definitions.Def_ChapterB4
open BookProof.ChapterB4
open BookProof.DensitySpectral



open Matrix
open scoped BigOperators ComplexOrder

variable {n : Type*} [Fintype n] [DecidableEq n]


theorem BookProof.DensitySpectral.density_marginal_conditional {ρ : Matrix n n ℂ} (h : IsDensityMatrix ρ) :
    ∃ (U : Matrix.unitaryGroup n ℂ) (d : n → ℝ),
      (∀ i, 0 ≤ d i) ∧ (∑ i, d i = 1) ∧
      (∀ i j, 0 ≤ bornKernel (U : Matrix n n ℂ) i j) ∧
      (∀ i, ∑ j, bornKernel (U : Matrix n n ℂ) i j = 1) ∧
      (∀ j, ∑ i, bornKernel (U : Matrix n n ℂ) i j = 1) ∧
      (∀ i, ρ i i = ((∑ k, bornKernel (U : Matrix n n ℂ) i k * d k : ℝ) : ℂ)) := by sorry
