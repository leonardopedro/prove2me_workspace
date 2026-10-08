-- Generated from ChapterDensityMarginalConditional.lean — theorem BookProof.DensitySpectral.bornKernel_col_sum
import Mathlib
import Definitions.Def_ChapterDensityMarginalConditional
open BookProof.DensitySpectral



open Matrix
open scoped BigOperators ComplexOrder

variable {n : Type*} [Fintype n] [DecidableEq n]


theorem BookProof.DensitySpectral.bornKernel_col_sum (U : Matrix.unitaryGroup n ℂ) (j : n) :
    ∑ i, bornKernel (U : Matrix n n ℂ) i j = 1 := by sorry
