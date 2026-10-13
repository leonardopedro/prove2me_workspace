-- Generated from ChapterSecondQuantizationCoreEsa.lean — solution of BookProof.SecondQuantizationCore.essentiallySelfAdjointOn_fockSectorCore
import Mathlib
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Theorems.Thm_BookProof_SecondQuantizationCore_isGraphCore_fockSectorCore
import Theorems.Thm_BookProof_GraphCore_essentiallySelfAdjointOn_of_graphCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterTensorGraphCore
open BookProof.SecondQuantizationCore




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore BookProof.DirectSumEsa
open BookProof.GraphCore
open BookProof.TensorCore

noncomputable section

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (hcore : IsGraphCore D A) (n : ℕ)
    (hesa : EssentiallySelfAdjointOn (fockSectorDom Hs D₂ n) (fockSectorOp Hs D₂ A n)) :
    EssentiallySelfAdjointOn (fockSectorCore Hs D₂ D n)
      (restrictOp (fockSectorOp Hs D₂ A n) (fockSectorCore_le_fockSectorDom Hs D₂ D n)) := essentiallySelfAdjointOn_of_graphCore _ _ (isGraphCore_fockSectorCore Hs D₂ A D hcore n) hesa
