-- Generated from ChapterSecondQuantizationCoreEsa.lean — solution of BookProof.SecondQuantizationCore.symmetricOn_dGammaCoreOp
import Mathlib
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Theorems.Thm_BookProof_SecondQuantizationCore_symmetricOn_fockSectorOp
open BookProof.SecondQuantizationCore




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore BookProof.DirectSumEsa

noncomputable section

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (hA : SymmetricOn D₂ A) :
    SymmetricOn (dsCore (fun n : ℕ => fockSectorCore Hs D₂ D n)) (dGammaCoreOp Hs D₂ A D) :=
  dsOp_symmetricOn _
      (fun n => symmetricOn_restrictOp _ _ (symmetricOn_fockSectorOp Hs D₂ A hA n))
