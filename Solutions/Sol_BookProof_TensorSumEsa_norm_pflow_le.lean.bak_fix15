-- Generated from ChapterTensorSumEsa.lean — solution of BookProof.TensorSumEsa.norm_pflow_le
import Mathlib
import Definitions.Def_ChapterTensorSumEsa
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
theorem solution (t : ℝ) (x : DA ⊗[ℂ] DB) : ‖pflow P Q t x‖ ≤ ‖x‖ := by

  have h := TensorOpBound.norm_map_le (OneParticleFlow.dmap P t) (OneParticleFlow.dmap Q t)
    zero_le_one
    zero_le_one (fun a => by rw [OneParticleFlow.norm_dmap]; simp)
    (fun b => by rw [OneParticleFlow.norm_dmap]; simp) x
  simpa [pflow] using h
