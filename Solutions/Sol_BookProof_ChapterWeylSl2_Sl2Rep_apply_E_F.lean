-- Generated from ChapterWeylSl2.lean — solution of BookProof.ChapterWeylSl2.Sl2Rep.apply_E_F
import Mathlib
import Definitions.Def_ChapterWeylSl2
open BookProof.ChapterWeylSl2
open BookProof.ChapterWeylSl2.Sl2Rep




universe u

variable {V : Type u} [AddCommGroup V] [Module ℂ V]

variable {V : Type u} [AddCommGroup V] [Module ℂ V]
variable (R : Sl2Rep V)
variable {R}
variable {R : Sl2Rep V}

set_option maxHeartbeats 1000000 in
theorem solution (v : V) : R.E (R.F v) = R.F (R.E v) + R.H v := by

  have h := congrArg (fun T : Module.End ℂ V => T v) R.hef
  simp only [Module.End.mul_apply, LinearMap.sub_apply] at h
  linear_combination (norm := abel) h
