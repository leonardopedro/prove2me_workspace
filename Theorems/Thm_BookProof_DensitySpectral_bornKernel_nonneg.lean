-- Generated from ChapterDensityMarginalConditional.lean — theorem BookProof.DensitySpectral.bornKernel_nonneg
import Mathlib
import Definitions.Def_ChapterDensityMarginalConditional
open BookProof.DensitySpectral

variable {n : Type*} [Fintype n] [DecidableEq n]



open Matrix
open scoped BigOperators ComplexOrder


omit [Fintype n] [DecidableEq n] in
theorem BookProof.DensitySpectral.bornKernel_nonneg (U : Matrix n n ℂ) (i j : n) : 0 ≤ bornKernel U i j := by sorry
