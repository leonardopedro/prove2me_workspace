-- Generated from ChapterScalarDGammaEsa.lean — solution of BookProof.ScalarDGamma.sectorDom_top
import Mathlib
import Definitions.Def_ChapterScalarDGammaEsa
import Theorems.Thm_BookProof_ScalarDGamma_inclPow_top_surjective
open BookProof.ScalarDGamma




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable (Hs : IPSpace) (c : ℝ)

variable (Hs : IPSpace) (c : ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) : sectorDom Hs ⊤ n = ⊤ := LinearMap.range_eq_top.mpr (inclPow_top_surjective Hs n)
