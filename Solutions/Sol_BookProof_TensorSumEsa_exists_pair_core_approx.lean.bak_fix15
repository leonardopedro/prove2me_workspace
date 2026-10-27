-- Generated from ChapterTensorSumEsa.lean — solution of BookProof.TensorSumEsa.exists_pair_core_approx
import Mathlib
import Definitions.Def_ChapterTensorSumEsa
import Theorems.Thm_BookProof_TensorSumEsa_graphPair_range_le_closure
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
theorem solution (hcoreA : IsGraphCore CA A) (hcoreB : IsGraphCore CB B)
    (x : DA ⊗[ℂ] DB) {ε : ℝ} (hε : 0 < ε) :
    ∃ y ∈ pairCorePoly Hs Ks DA DB CA CB,
      ‖inclPair Hs Ks DA DB x - inclPair Hs Ks DA DB y‖ < ε ∧
        ‖sumPoly Hs Ks DA DB A B x - sumPoly Hs Ks DA DB A B y‖ < ε := by

  have hmem : graphPair Hs Ks DA DB A B x ∈
      closure ((Submodule.map (graphPair Hs Ks DA DB A B)
        (pairCorePoly Hs Ks DA DB CA CB)) : Set _) :=
    graphPair_range_le_closure Hs Ks DA DB A B CA CB hcoreA hcoreB ⟨x, rfl⟩
  obtain ⟨z, hz, hdist⟩ := Metric.mem_closure_iff.mp hmem ε hε
  obtain ⟨y, hy, rfl⟩ := hz
  refine ⟨y, hy, ?_, ?_⟩
  · have := (max_lt_iff.mp (by simpa [Prod.dist_eq, dist_eq_norm] using hdist)).1
    simpa using this
  · have := (max_lt_iff.mp (by simpa [Prod.dist_eq, dist_eq_norm] using hdist)).2
    simpa using this
