-- Generated from ChapterScalarDGammaEsa.lean — theorem BookProof.ScalarDGamma.inclPow_top_surjective
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


theorem BookProof.ScalarDGamma.inclPow_top_surjective (n : ℕ) : Function.Surjective (inclPow Hs ⊤ n) := by sorry
