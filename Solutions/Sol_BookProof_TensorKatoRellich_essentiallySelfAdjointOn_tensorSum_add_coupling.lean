-- Generated from ChapterTensorKatoRellich.lean — solution of BookProof.TensorKatoRellich.essentiallySelfAdjointOn_tensorSum_add_coupling
import Mathlib
import Definitions.Def_ChapterTensorKatoRellich
import Theorems.Thm_BookProof_TensorKatoRellich_symmetricOn_coupling
import Theorems.Thm_BookProof_TensorKatoRellich_coupling_relBound
import Theorems.Thm_BookProof_KatoRellich_essentiallySelfAdjointOn_add_relBounded
import Theorems.Thm_BookProof_TensorSumEsa_symmetricOn_cpairOp
open BookProof.TensorKatoRellich




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore BookProof.TensorSumEsa

noncomputable section

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
variable {ι : Type*} [Fintype ι]

set_option maxHeartbeats 1000000 in
theorem solution [FiniteDimensional ℂ DB]
    (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)
    (V : ι → DA →ₗ[ℂ] Hs.carrier) (Y : ι → DB →ₗ[ℂ] Ks.carrier)
    (hA : SymmetricOn DA A) (hB : SymmetricOn DB B)
    (hV : ∀ i, SymmetricOn DA (V i)) (hY : ∀ i, SymmetricOn DB (Y i))
    (hrel : ∀ i, ∀ ε : ℝ, 0 < ε → ∃ C : ℝ, ∀ u : DA,
      ‖V i u‖ ≤ ε * ‖A u‖ + C * ‖(u : Hs.carrier)‖)
    (hesa : EssentiallySelfAdjointOn (cpairDom Hs Ks DA DB) (cpairOp Hs Ks DA DB A B)) :
    EssentiallySelfAdjointOn (cpairDom Hs Ks DA DB)
      (cpairOp Hs Ks DA DB A B + pairLiftOp Hs Ks DA DB (couplingPoly Hs Ks DA DB V Y)) := by

  obtain ⟨a, b, ha, ha1, hb, hbound⟩ := coupling_relBound Hs Ks DA DB A B V Y hrel
  exact KatoRellich.essentiallySelfAdjointOn_add_relBounded _ _
    (symmetricOn_cpairOp Hs Ks DA DB A B hA hB) hesa
    (symmetricOn_coupling Hs Ks DA DB V Y hV hY) ha ha1 hb hbound
