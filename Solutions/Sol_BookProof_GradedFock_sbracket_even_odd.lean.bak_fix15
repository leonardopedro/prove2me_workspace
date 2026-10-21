-- Generated from ChapterGradedFock.lean — solution of BookProof.GradedFock.sbracket_even_odd
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
    sbracket false true a b = a * b - b * a := by

  rw [sbracket, eps_false_left]
  norm_num
