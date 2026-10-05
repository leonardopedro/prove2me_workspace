-- Generated from ChapterGradedFock.lean — solution of BookProof.GradedFock.gradeOp_oddPart
import Mathlib
import Definitions.Def_ChapterGradedFock
import Theorems.Thm_BookProof_GradedFock_gradeOp_involutive
open BookProof.GradedFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FockSecondQuantization BookProof.FermionFock
open BookProof.ChapterSuperBracket

noncomputable section

variable {α β : Type*}
variable (T T' : Module.End ℂ (α →₀ ℂ)) (S S' : Module.End ℂ (β →₀ ℂ))

set_option maxHeartbeats 1000000 in
theorem solution (u : GradedAlg) : gradeOp (oddPart u) = - oddPart u := by

  have hsq : gradeOp (gradeOp u) = u := by
    have := congrArg (fun T : Module.End ℂ GradedAlg => T u) gradeOp_involutive
    simpa only [Module.End.mul_apply, Module.End.one_apply] using this
  rw [oddPart, map_smul, map_sub, hsq, ← smul_neg]
  congr 1
  abel
