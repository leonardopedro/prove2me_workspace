-- Generated from ChapterSecondQuantizationCoreEsa.lean — solution of BookProof.SecondQuantizationCore.dGamma_essentiallySelfAdjointOn_fockCore
import Mathlib
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Theorems.Thm_BookProof_SecondQuantizationCore_essentiallySelfAdjointOn_fockSectorCore
open BookProof.SecondQuantizationCore




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore BookProof.DirectSumEsa

noncomputable section

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (hcore : IsGraphCore D A)
    (hsector : ∀ n : ℕ,
      EssentiallySelfAdjointOn (fockSectorDom Hs D₂ n) (fockSectorOp Hs D₂ A n)) :
    EssentiallySelfAdjointOn (dsCore (fun n : ℕ => fockSectorCore Hs D₂ D n))
      (dGammaCoreOp Hs D₂ A D) :=
  dsOp_essentiallySelfAdjointOn _
      (fun n => essentiallySelfAdjointOn_fockSectorCore Hs D₂ A D hcore n (hsector n))
