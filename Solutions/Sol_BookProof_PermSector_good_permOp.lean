-- Generated from ChapterPermutationSectorEsa.lean — solution of BookProof.PermSector.good_permOp
import Mathlib
import Definitions.Def_ChapterPermutationSectorEsa
import Theorems.Thm_BookProof_PermSector_good_refl
import Theorems.Thm_BookProof_PermSector_good_trans
import Theorems.Thm_BookProof_PermSector_good_liftTail
import Theorems.Thm_BookProof_PermSector_good_swap0
import Theorems.Thm_BookProof_TensorPerm_permOp_succ
open BookProof.PermSector




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore
open BookProof.GroupAverage BookProof.TensorPerm

noncomputable section

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution : ∀ (n : ℕ) (σ : Equiv.Perm (Fin n)),
    Good Hs D₂ A D n (permOp (domSpace Hs D₂) n σ) (permOp Hs n σ) := by

  intro n
  induction n with
  | zero => intro σ; exact good_refl Hs D₂ A D 0
  | succ n ih =>
      intro σ
      rw [permOp_succ, permOp_succ]
      exact good_trans Hs D₂ A D (good_swap0 Hs D₂ A D n (Equiv.Perm.decomposeFin σ).1)
        (good_liftTail Hs D₂ A D (ih (Equiv.Perm.decomposeFin σ).2))
