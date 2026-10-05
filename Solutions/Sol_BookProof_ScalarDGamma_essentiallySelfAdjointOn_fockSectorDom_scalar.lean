-- Generated from ChapterScalarDGammaEsa.lean — solution of BookProof.ScalarDGamma.essentiallySelfAdjointOn_fockSectorDom_scalar
import Mathlib
import Definitions.Def_ChapterScalarDGammaEsa
import Theorems.Thm_BookProof_ScalarDGamma_symmetricOn_scalarOp
import Theorems.Thm_BookProof_ScalarDGamma_dense_fockSectorDom
import Theorems.Thm_BookProof_ScalarDGamma_norm_fockSectorOp_scalar_le
import Theorems.Thm_BookProof_SecondQuantizationCore_symmetricOn_fockSectorOp
open BookProof.ScalarDGamma




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable (Hs : IPSpace) (c : ℝ)

variable (Hs : IPSpace) (c : ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) :
    EssentiallySelfAdjointOn (fockSectorDom Hs ⊤ n) (fockSectorOp Hs ⊤ (scalarOp Hs c) n) :=
  essentiallySelfAdjointOn_of_bounded_dense _
      (symmetricOn_fockSectorOp Hs ⊤ (scalarOp Hs c) (symmetricOn_scalarOp Hs c) n)
      (by positivity) (norm_fockSectorOp_scalar_le Hs c n) (dense_fockSectorDom Hs n)
