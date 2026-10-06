-- Generated from ChapterDensityMarginalConditional.lean — solution of BookProof.DensitySpectral.bornKernel_nonneg
import Mathlib
import Definitions.Def_ChapterDensityMarginalConditional
open BookProof.DensitySpectral




open Matrix
open scoped BigOperators ComplexOrder

variable {n : Type*} [Fintype n] [DecidableEq n]

variable {n : Type*} [Fintype n] [DecidableEq n]

set_option maxHeartbeats 1000000 in
omit [Fintype n] [DecidableEq n] in
theorem solution (U : Matrix n n ℂ) (i j : n) : 0 ≤ bornKernel U i j := Complex.normSq_nonneg _
