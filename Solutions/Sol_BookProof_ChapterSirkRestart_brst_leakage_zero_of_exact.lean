-- Generated from ChapterSirkRestart.lean — solution of BookProof.ChapterSirkRestart.brst_leakage_zero_of_exact
import Mathlib
import Definitions.Def_ChapterSirkRestart
import Theorems.Thm_BookProof_ChapterSirkRestart_comp_pow_of_comm
open BookProof.ChapterSirkRestart








noncomputable section

open Filter Topology


open BookProof.ChapterH6

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution (U Om : E →L[ℂ] E)
    (hcomm : Om.comp U = U.comp Om) (n : ℕ) (v : E) (hv : Om v = 0) :
    Om ((U ^ n) v) = 0 := by

  have h : Om ((U ^ n) v) = (U ^ n) (Om v) :=
    congrArg (fun f : E →L[ℂ] E => f v) (comp_pow_of_comm U Om hcomm n)
  rw [h, hv, map_zero]
