-- Generated from ChapterScalarDGammaEsa.lean — theorem BookProof.ScalarDGamma.norm_fockSectorOp_scalar_le
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterScalarDGammaEsa
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterA4
open BookProof.TensorCore

variable (Hs : IPSpace) (c : ℝ)



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section


theorem BookProof.ScalarDGamma.norm_fockSectorOp_scalar_le (n : ℕ) (x : fockSectorDom Hs ⊤ n) :
    ‖fockSectorOp Hs ⊤ (scalarOp Hs c) n x‖ ≤ ((n : ℝ) * |c|) * ‖(x : fockSector Hs n)‖ := by sorry
