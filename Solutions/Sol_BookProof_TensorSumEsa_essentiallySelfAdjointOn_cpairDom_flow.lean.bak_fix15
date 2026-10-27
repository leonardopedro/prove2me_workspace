-- Generated from ChapterTensorSumEsa.lean — solution of BookProof.TensorSumEsa.essentiallySelfAdjointOn_cpairDom_flow
import Mathlib
import Definitions.Def_ChapterTensorSumEsa
import Theorems.Thm_BookProof_TensorSumEsa_dense_cpairDom
import Theorems.Thm_BookProof_TensorSumEsa_porbit_zero
import Theorems.Thm_BookProof_TensorSumEsa_norm_porbit
import Theorems.Thm_BookProof_TensorSumEsa_hasDerivAt_porbit
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
theorem solution
    (hA : Dense (DA : Set Hs.carrier)) (hB : Dense (DB : Set Ks.carrier)) :
    EssentiallySelfAdjointOn (cpairDom Hs Ks DA DB) (cpairOp Hs Ks DA DB A B) := by

  have hrange : (Set.range fun x : DA ⊗[ℂ] DB =>
      ((porbit P Q x 0 : cpairDom Hs Ks DA DB) : ctensor Hs Ks))
      = ((cpairDom Hs Ks DA DB : Submodule ℂ (ctensor Hs Ks)) : Set (ctensor Hs Ks)) := by
    ext z
    constructor
    · rintro ⟨x, rfl⟩
      exact (porbit P Q x 0).2
    · rintro ⟨w, ⟨x, rfl⟩, rfl⟩
      refine ⟨x, ?_⟩
      exact porbit_zero P Q x
  have hdense : Dense ((Submodule.span ℂ (Set.range fun x : DA ⊗[ℂ] DB =>
      ((porbit P Q x 0 : cpairDom Hs Ks DA DB) : ctensor Hs Ks)) :
      Submodule ℂ (ctensor Hs Ks)) : Set (ctensor Hs Ks)) := by
    rw [hrange, Submodule.span_eq]
    exact dense_cpairDom Hs Ks DA DB hA hB
  exact essentiallySelfAdjointOn_of_orbits _ (fun x => porbit P Q x)
    (fun x t => norm_porbit P Q x t) (fun x t => hasDerivAt_porbit P Q x t) hdense
