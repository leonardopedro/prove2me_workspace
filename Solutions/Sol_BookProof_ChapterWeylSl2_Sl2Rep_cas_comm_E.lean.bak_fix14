-- Generated from ChapterWeylSl2.lean — solution of BookProof.ChapterWeylSl2.Sl2Rep.cas_comm_E
import Mathlib
import Definitions.Def_ChapterWeylSl2
import Theorems.Thm_BookProof_ChapterWeylSl2_Sl2Rep_eh_prime
open BookProof.ChapterWeylSl2
open BookProof.ChapterWeylSl2.Sl2Rep




universe u

variable {V : Type u} [AddCommGroup V] [Module ℂ V]

variable {V : Type u} [AddCommGroup V] [Module ℂ V]
variable (R : Sl2Rep V)
variable {R}

set_option maxHeartbeats 1000000 in
theorem solution : R.cas * R.E = R.E * R.cas := by

  have k1 : R.E * R.E - R.E * R.E = 0 := sub_self _
  have key : R.E * R.cas - R.cas * R.E
      = 2 • (((R.E * R.E - R.E * R.E) * R.F + R.E * (R.E * R.F - R.F * R.E))
          + ((R.E * R.F - R.F * R.E) * R.E + R.F * (R.E * R.E - R.E * R.E)))
        + ((R.E * R.H - R.H * R.E) * R.H + R.H * (R.E * R.H - R.H * R.E)) := by
    simp only [cas]; noncomm_ring
  rw [k1, R.hef, eh_prime] at key
  have h0 : R.E * R.cas - R.cas * R.E = 0 := by rw [key]; noncomm_ring
  exact (sub_eq_zero.mp h0).symm
