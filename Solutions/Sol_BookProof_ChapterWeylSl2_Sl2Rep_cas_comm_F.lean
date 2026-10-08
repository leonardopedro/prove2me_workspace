-- Generated from ChapterWeylSl2.lean — solution of BookProof.ChapterWeylSl2.Sl2Rep.cas_comm_F
import Mathlib
import Definitions.Def_ChapterWeylSl2
import Theorems.Thm_BookProof_ChapterWeylSl2_Sl2Rep_fh_prime
open BookProof.ChapterWeylSl2
open BookProof.ChapterWeylSl2.Sl2Rep




universe u

variable {V : Type u} [AddCommGroup V] [Module ℂ V]

variable {V : Type u} [AddCommGroup V] [Module ℂ V]
variable (R : Sl2Rep V)
variable {R}

set_option maxHeartbeats 1000000 in
theorem solution : R.cas * R.F = R.F * R.cas := by

  have k1 : R.F * R.F - R.F * R.F = 0 := sub_self _
  have k2 : R.F * R.E - R.E * R.F = -R.H := by rw [← neg_sub (R.E * R.F), R.hef]
  have key : R.F * R.cas - R.cas * R.F
      = 2 • (((R.F * R.E - R.E * R.F) * R.F + R.E * (R.F * R.F - R.F * R.F))
          + ((R.F * R.F - R.F * R.F) * R.E + R.F * (R.F * R.E - R.E * R.F)))
        + ((R.F * R.H - R.H * R.F) * R.H + R.H * (R.F * R.H - R.H * R.F)) := by
    simp only [cas]; noncomm_ring
  rw [k1, k2, fh_prime] at key
  have h0 : R.F * R.cas - R.cas * R.F = 0 := by rw [key]; noncomm_ring
  exact (sub_eq_zero.mp h0).symm
