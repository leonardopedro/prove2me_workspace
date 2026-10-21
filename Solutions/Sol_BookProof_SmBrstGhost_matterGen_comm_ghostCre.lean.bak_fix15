-- Generated from ChapterSmBrstGhost.lean — solution of BookProof.SmBrstGhost.matterGen_comm_ghostCre
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
import Theorems.Thm_BookProof_SmBrstGhost_fermiBilin_comm_creat
import Theorems.Thm_BookProof_SmBrstGhost_embedMatter_col_ghost
open BookProof.SmBrstGhost




open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

variable {m : ℕ}
variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {N : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (m : ℕ) (T : Fin 12 → Matrix (Fin m) (Fin m) ℂ) (a b : Fin 12) :
    matterGen m T a * ghostCre m b = ghostCre m b * matterGen m T a := by

  rw [matterGen, ghostCre, smul_mul_assoc, mul_smul_comm,
    fermiBilin_comm_creat (fun i => embedMatter_col_ghost m (T a) b i)]
