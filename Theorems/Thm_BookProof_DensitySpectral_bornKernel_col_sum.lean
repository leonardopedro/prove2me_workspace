-- Generated from ChapterDensityMarginalConditional.lean — theorem BookProof.DensitySpectral.bornKernel_col_sum
import Mathlib
import Definitions.Def_ChapterDensityMarginalConditional
open BookProof.DensitySpectral

variable {n : Type*} [Fintype n] [DecidableEq n]



open Matrix
open scoped BigOperators ComplexOrder


theorem BookProof.DensitySpectral.bornKernel_col_sum (U : Matrix.unitaryGroup n ℂ) (j : n) :
    ∑ i, bornKernel (U : Matrix n n ℂ) i j = 1 := by sorry
