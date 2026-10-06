-- Generated from ChapterDensityMarginalConditional.lean — theorem BookProof.DensitySpectral.bornKernel_row_sum
import Mathlib
import Definitions.Def_ChapterDensityMarginalConditional
open BookProof.DensitySpectral

variable {n : Type*} [Fintype n] [DecidableEq n]



open Matrix
open scoped BigOperators ComplexOrder


theorem BookProof.DensitySpectral.bornKernel_row_sum (U : Matrix.unitaryGroup n ℂ) (i : n) :
    ∑ j, bornKernel (U : Matrix n n ℂ) i j = 1 := by sorry
