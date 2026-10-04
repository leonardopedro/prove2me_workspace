-- Generated from ChapterScalarDGammaEsa.lean — theorem BookProof.ScalarDGamma.inclPow_top_surjective
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterScalarDGammaEsa
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterA4
open BookProof.TensorCore
open BookProof.ScalarDGamma

variable (Hs : IPSpace) (c : ℝ)



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section


theorem BookProof.ScalarDGamma.inclPow_top_surjective (n : ℕ) : Function.Surjective (inclPow Hs ⊤ n) := by sorry
