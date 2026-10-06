-- Generated from ChapterSmBrstGhost.lean — solution of BookProof.SmBrstGhost.ghostNumber_occ
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
import Theorems.Thm_BookProof_SmBrstGhost_occupation_occ
open BookProof.SmBrstGhost




open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (m : ℕ) (S : Finset (Fin (m + 12))) :
    ghostNumber m (occ S)
      = (Finset.univ.filter (fun a : Fin 12 => ghostMode m a ∈ S)).card • occ S := by

  classical
  rw [ghostNumber, LinearMap.sum_apply]
  have hterm : ∀ a : Fin 12, (ghostCre m a * ghostAnn m a) (occ S)
      = if ghostMode m a ∈ S then occ S else 0 := fun a => occupation_occ (ghostMode m a) S
  rw [Finset.sum_congr rfl fun a (_ : a ∈ Finset.univ) => hterm a]
  rw [Finset.sum_ite, Finset.sum_const, Finset.sum_const_zero, add_zero]
