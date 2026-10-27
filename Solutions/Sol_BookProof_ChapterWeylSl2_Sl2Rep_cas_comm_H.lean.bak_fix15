-- Generated from ChapterWeylSl2.lean — solution of BookProof.ChapterWeylSl2.Sl2Rep.cas_comm_H
import Mathlib
import Definitions.Def_ChapterWeylSl2
open BookProof.ChapterWeylSl2
open BookProof.ChapterWeylSl2.Sl2Rep




universe u

variable {V : Type u} [AddCommGroup V] [Module ℂ V]

variable {V : Type u} [AddCommGroup V] [Module ℂ V]
variable (R : Sl2Rep V)
variable {R}

set_option maxHeartbeats 1000000 in
theorem solution : R.cas * R.H = R.H * R.cas := by

  have k1 : R.H * R.H - R.H * R.H = 0 := sub_self _
  have key : R.H * R.cas - R.cas * R.H
      = 2 • (((R.H * R.E - R.E * R.H) * R.F + R.E * (R.H * R.F - R.F * R.H))
          + ((R.H * R.F - R.F * R.H) * R.E + R.F * (R.H * R.E - R.E * R.H)))
        + ((R.H * R.H - R.H * R.H) * R.H + R.H * (R.H * R.H - R.H * R.H)) := by
    simp only [cas]; noncomm_ring
  rw [k1, R.he, R.hf] at key
  have h0 : R.H * R.cas - R.cas * R.H = 0 := by rw [key]; noncomm_ring
  exact (sub_eq_zero.mp h0).symm
