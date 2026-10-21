-- Generated from ChapterTensorSumEsa.lean — solution of BookProof.TensorSumEsa.norm_porbit
import Mathlib
import Definitions.Def_ChapterTensorSumEsa
import Theorems.Thm_BookProof_TensorSumEsa_norm_pflow
import Theorems.Thm_BookProof_TensorSumEsa_porbit_zero
open BookProof.TensorSumEsa




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
variable (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)
variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
  (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)
variable {Hs Ks : IPSpace} {DA : Submodule ℂ Hs.carrier} {DB : Submodule ℂ Ks.carrier}
  {A : DA →ₗ[ℂ] Hs.carrier} {B : DB →ₗ[ℂ] Ks.carrier}
variable (P : OneParticleFlow Hs DA A) (Q : OneParticleFlow Ks DB B)

set_option maxHeartbeats 1000000 in
theorem solution (x : DA ⊗[ℂ] DB) (t : ℝ) :
    ‖((porbit P Q x t : cpairDom Hs Ks DA DB) : ctensor Hs Ks)‖
      = ‖((porbit P Q x 0 : cpairDom Hs Ks DA DB) : ctensor Hs Ks)‖ := by

  rw [porbit_coe, porbit_zero, (pairEmb Hs Ks).norm_map, (pairEmb Hs Ks).norm_map,
    (inclPair Hs Ks DA DB).norm_map, (inclPair Hs Ks DA DB).norm_map, norm_pflow]
