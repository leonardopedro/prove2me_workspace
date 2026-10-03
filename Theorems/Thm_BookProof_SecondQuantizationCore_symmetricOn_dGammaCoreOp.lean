-- Generated from ChapterSecondQuantizationCoreEsa.lean — theorem BookProof.SecondQuantizationCore.symmetricOn_dGammaCoreOp
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterA4
open BookProof.DirectSumEsa
open BookProof.GraphCore
open BookProof.TensorCore

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore BookProof.DirectSumEsa

noncomputable section


theorem BookProof.SecondQuantizationCore.symmetricOn_dGammaCoreOp (hA : SymmetricOn D₂ A) :
    SymmetricOn (dsCore (fun n : ℕ => fockSectorCore Hs D₂ D n)) (dGammaCoreOp Hs D₂ A D) := by sorry
