-- Generated from ChapterDensityMarginalConditional.lean — theorem BookProof.DensitySpectral.bornKernel_nonneg
import Mathlib
import Definitions.Def_ChapterDensityMarginalConditional
open BookProof.DensitySpectral



open Matrix
open scoped BigOperators ComplexOrder

variable {n : Type*} [Fintype n] [DecidableEq n]


omit [Fintype n] [DecidableEq n] in
theorem BookProof.DensitySpectral.bornKernel_nonneg (U : Matrix n n ℂ) (i j : n) : 0 ≤ bornKernel U i j := by sorry
