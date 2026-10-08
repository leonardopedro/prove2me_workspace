-- Generated from ChapterScalarDGammaEsa.lean — theorem BookProof.ScalarDGamma.derPow_scalar
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterScalarDGammaEsa
import Definitions.Def_ChapterTensorGraphCore
open BookProof.TensorCore
open BookProof.ScalarDGamma



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable (Hs : IPSpace) (c : ℝ)


theorem BookProof.ScalarDGamma.derPow_scalar (n : ℕ) (x : ((domSpace Hs ⊤).pow n)) :
    derPow Hs ⊤ (scalarOp Hs c) n x = ((n : ℂ) * c) • inclPow Hs ⊤ n x := by sorry
