-- Generated from ChapterDensityMarginalConditional.lean — theorem BookProof.DensitySpectral.density_diag_eq_kernel_apply
import Mathlib
import Definitions.Def_ChapterDensityMarginalConditional
open BookProof.DensitySpectral



open Matrix
open scoped BigOperators ComplexOrder

variable {n : Type*} [Fintype n] [DecidableEq n]


theorem BookProof.DensitySpectral.density_diag_eq_kernel_apply (U : Matrix n n ℂ) (d : n → ℝ) (i : n) :
    (U * Matrix.diagonal (RCLike.ofReal ∘ d) * Uᴴ : Matrix n n ℂ) i i
      = ((∑ k, bornKernel U i k * d k : ℝ) : ℂ) := by sorry
