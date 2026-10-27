-- Generated from ChapterSmBrstGhost.lean — solution of BookProof.SmBrstGhost.smBrstCharge_nilpotent
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
import Theorems.Thm_BookProof_SmBrstGhost_smStruct_antisymm
import Theorems.Thm_BookProof_SmBrstGhost_smStruct_jacobi
import Theorems.Thm_BookProof_SmBrstGhost_smGhostCAR
import Theorems.Thm_BookProof_SmBrstGhost_brstCharge_nilpotent
import Theorems.Thm_BookProof_SmBrstGhost_matterGen_lie
import Theorems.Thm_BookProof_SmBrstGhost_matterGen_comm_ghostAnn
import Theorems.Thm_BookProof_SmBrstGhost_matterGen_comm_ghostCre
open BookProof.SmBrstGhost




open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

variable {m : ℕ}
variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {N : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {m : ℕ} {T : Fin 12 → Matrix (Fin m) (Fin m) ℂ}
    {f3 : Fin 8 → Fin 8 → Fin 8 → ℝ} (hT : ClosesWithStructureConstants T (smStruct f3))
    (h3anti : ∀ a b c, f3 a b c = -f3 b a c)
    (h3jac : ∀ a b c h : Fin 8, ∑ e, (f3 a b e * f3 e c h + f3 b c e * f3 e a h
      + f3 c a e * f3 e b h) = 0) :
    smBrstCharge m T f3 * smBrstCharge m T f3 = 0 :=
  brstCharge_nilpotent (smStruct f3) (ghostCre m) (ghostAnn m) (matterGen m T) (smGhostCAR m)
      (matterGen_comm_ghostCre m T) (matterGen_comm_ghostAnn m T)
      (fun a b => matterGen_lie hT a b) (smStruct_antisymm h3anti) (smStruct_jacobi h3jac)
