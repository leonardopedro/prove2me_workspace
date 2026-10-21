-- Generated from ChapterTensorSumEsa.lean — solution of BookProof.TensorSumEsa.graphPair_range_le_closure
import Mathlib
import Definitions.Def_ChapterTensorSumEsa
import Theorems.Thm_BookProof_TensorSumEsa_mem_span_tmul
import Theorems.Thm_BookProof_TensorSumEsa_graphPair_tmul_mem_closure
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
variable {Hs Ks : IPSpace} [CompleteSpace Hs.carrier] [CompleteSpace Ks.carrier]
variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
  (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)
  (CA : Submodule ℂ Hs.carrier) (CB : Submodule ℂ Ks.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (hcoreA : IsGraphCore CA A) (hcoreB : IsGraphCore CB B) :
    LinearMap.range (graphPair Hs Ks DA DB A B)
      ≤ (Submodule.map (graphPair Hs Ks DA DB A B)
        (pairCorePoly Hs Ks DA DB CA CB)).topologicalClosure := by

  rintro y ⟨x, rfl⟩
  induction (mem_span_tmul x) using Submodule.span_induction with
  | mem t ht =>
      obtain ⟨p, q, rfl⟩ := ht
      exact graphPair_tmul_mem_closure Hs Ks DA DB A B CA CB hcoreA hcoreB p q
  | zero => rw [map_zero]; exact Submodule.zero_mem _
  | add s t _ _ hs ht => simpa [map_add] using Submodule.add_mem _ hs ht
  | smul c s _ hs => simpa [map_smul] using Submodule.smul_mem _ c hs
