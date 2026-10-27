-- Generated from ChapterScalarDGammaEsa.lean — solution of BookProof.ScalarDGamma.symmetricOn_scalarOp
import Mathlib
import Definitions.Def_ChapterScalarDGammaEsa
import Theorems.Thm_BookProof_ScalarDGamma_scalarOp_apply
open BookProof.ScalarDGamma




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable (Hs : IPSpace) (c : ℝ)

variable (Hs : IPSpace) (c : ℝ)

set_option maxHeartbeats 1000000 in
theorem solution : SymmetricOn ⊤ (scalarOp Hs c) := by

  intro x y
  rw [scalarOp_apply, scalarOp_apply, inner_smul_left, inner_smul_right, Complex.conj_ofReal]
