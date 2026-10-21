-- Generated from ChapterDensityMarginalConditional.lean — solution of BookProof.DensitySpectral.density_diag_isProbability
import Mathlib
import Definitions.Def_ChapterDensityMarginalConditional
open BookProof.DensitySpectral




open Matrix
open scoped BigOperators ComplexOrder

variable {n : Type*} [Fintype n] [DecidableEq n]

variable {n : Type*} [Fintype n] [DecidableEq n]

set_option maxHeartbeats 1000000 in
theorem solution {ρ : Matrix n n ℂ} (h : IsDensityMatrix ρ) :
    (∀ i, 0 ≤ (ρ i i).re) ∧ ∑ i, (ρ i i).re = 1 := by

  constructor
  · intro i
    exact (RCLike.nonneg_iff.mp (h.2.1.diag_nonneg (i := i))).1
  · have h1 : (∑ i, ρ i i) = 1 := by simpa [Matrix.trace, Matrix.diag] using h.2.2
    simpa using congrArg Complex.re h1
