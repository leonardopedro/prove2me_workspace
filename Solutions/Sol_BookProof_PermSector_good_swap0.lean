-- Generated from ChapterPermutationSectorEsa.lean — solution of BookProof.PermSector.good_swap0
import Mathlib
import Definitions.Def_ChapterPermutationSectorEsa
import Theorems.Thm_BookProof_PermSector_good_refl
import Theorems.Thm_BookProof_PermSector_good_trans
import Theorems.Thm_BookProof_PermSector_good_liftTail
import Theorems.Thm_BookProof_PermSector_good_swapFirst
open BookProof.PermSector




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore
open BookProof.GroupAverage BookProof.TensorPerm

noncomputable section

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution : ∀ (n : ℕ) (p : Fin (n + 1)),
    Good Hs D₂ A D (n + 1) (swap0 (domSpace Hs D₂) (n + 1) p) (swap0 Hs (n + 1) p) := by

  intro n
  induction n with
  | zero =>
      intro p
      rw [swap0_one, swap0_one]
      exact good_refl Hs D₂ A D 1
  | succ n ih =>
      intro p
      refine Fin.cases ?_ ?_ p
      · rw [swap0_zero, swap0_zero]
        exact good_refl Hs D₂ A D (n + 2)
      · intro j
        rw [swap0_succ, swap0_succ]
        exact good_trans Hs D₂ A D (good_liftTail Hs D₂ A D (ih j))
          (good_trans Hs D₂ A D (good_swapFirst Hs D₂ A D n)
            (good_liftTail Hs D₂ A D (ih j)))
