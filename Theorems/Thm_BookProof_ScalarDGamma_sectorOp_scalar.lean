-- Generated from ChapterScalarDGammaEsa.lean — theorem BookProof.ScalarDGamma.sectorOp_scalar
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


theorem BookProof.ScalarDGamma.sectorOp_scalar (n : ℕ) (x : sectorDom Hs ⊤ n) :
    sectorOp Hs ⊤ (scalarOp Hs c) n x = ((n : ℂ) * c) • (x : (Hs.pow n).carrier) := by sorry
