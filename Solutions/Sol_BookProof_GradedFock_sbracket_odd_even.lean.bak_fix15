-- Generated from ChapterGradedFock.lean — solution of BookProof.GradedFock.sbracket_odd_even
import Mathlib
import Definitions.Def_ChapterGradedFock
open BookProof.GradedFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FockSecondQuantization BookProof.FermionFock
open BookProof.ChapterSuperBracket

noncomputable section

variable {α β : Type*}
variable (T T' : Module.End ℂ (α →₀ ℂ)) (S S' : Module.End ℂ (β →₀ ℂ))

set_option maxHeartbeats 1000000 in
theorem solution (a b : Module.End ℂ GradedAlg) :
    sbracket true false a b = a * b - b * a := by

  rw [sbracket, eps_false_right]
  norm_num
