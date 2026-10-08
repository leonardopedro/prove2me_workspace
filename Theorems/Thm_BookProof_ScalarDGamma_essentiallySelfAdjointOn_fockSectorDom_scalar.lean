-- Generated from ChapterScalarDGammaEsa.lean — theorem BookProof.ScalarDGamma.essentiallySelfAdjointOn_fockSectorDom_scalar
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterScalarDGammaEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterTensorGraphCore
open BookProof.TensorCore
open BookProof.ScalarDGamma



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable (Hs : IPSpace) (c : ℝ)


theorem BookProof.ScalarDGamma.essentiallySelfAdjointOn_fockSectorDom_scalar (n : ℕ) :
    EssentiallySelfAdjointOn (fockSectorDom Hs ⊤ n) (fockSectorOp Hs ⊤ (scalarOp Hs c) n) := by sorry
