-- Generated from ChapterSmBrstGhost.lean — solution of BookProof.SmBrstGhost.occupation_occ
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
import Theorems.Thm_BookProof_SmCar_occupation_apply
open BookProof.SmBrstGhost




open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {N : ℕ} (i : Fin N) (S : Finset (Fin N)) :
    creat i (annih i (occ S)) = if i ∈ S then occ S else 0 := by

  ext T
  rw [occupation_apply]
  by_cases h : i ∈ S <;> by_cases hT : T = S <;>
    simp [h, hT, occ, EuclideanSpace.single_apply]
