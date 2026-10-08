-- Generated from ChapterScalarDGammaEsa.lean — theorem BookProof.ScalarDGamma.dense_fockSectorDom
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterScalarDGammaEsa
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterTensorGraphCore
open BookProof.GraphCore
open BookProof.TensorCore
open BookProof.ScalarDGamma



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable (Hs : IPSpace) (c : ℝ)


theorem BookProof.ScalarDGamma.dense_fockSectorDom (n : ℕ) :
    Dense ((fockSectorDom Hs ⊤ n : Submodule ℂ (fockSector Hs n)) :
      Set (fockSector Hs n)) := by sorry
