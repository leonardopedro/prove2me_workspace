-- Generated from ChapterScalarDGammaEsa.lean — theorem BookProof.ScalarDGamma.dGamma_scalar_essentiallySelfAdjointOn_fockCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterScalarDGammaEsa
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterTensorGraphCore
open BookProof.DirectSumEsa
open BookProof.TensorCore
open BookProof.ScalarDGamma

variable (Hs : IPSpace) (c : ℝ)



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section


theorem BookProof.ScalarDGamma.dGamma_scalar_essentiallySelfAdjointOn_fockCore {D : Submodule ℂ Hs.carrier}
    (hdense : Dense (D : Set Hs.carrier)) :
    EssentiallySelfAdjointOn (dsCore (fun n : ℕ => fockSectorCore Hs ⊤ D n))
      (dGammaCoreOp Hs ⊤ (scalarOp Hs c) D) := by sorry
