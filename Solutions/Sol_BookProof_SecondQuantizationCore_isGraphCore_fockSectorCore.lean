-- Generated from ChapterSecondQuantizationCoreEsa.lean — solution of BookProof.SecondQuantizationCore.isGraphCore_fockSectorCore
import Mathlib
import Definitions.Def_ChapterSecondQuantizationCoreEsa
open BookProof.SecondQuantizationCore




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore BookProof.DirectSumEsa

noncomputable section

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (hcore : IsGraphCore D A) (n : ℕ) :
    IsGraphCore (fockSectorCore Hs D₂ D n) (fockSectorOp Hs D₂ A n) := isGraphCore_pushOp _ _ (isGraphCore_sectorCore Hs D₂ A D hcore n)
