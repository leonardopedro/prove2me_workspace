-- Generated from ChapterGradedFock.lean — solution of BookProof.GradedFock.liftSnd_single
import Mathlib
import Definitions.Def_ChapterGradedFock
open BookProof.GradedFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FockSecondQuantization BookProof.FermionFock
open BookProof.ChapterSuperBracket

noncomputable section

variable {α β : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (S : (β →₀ ℂ) →ₗ[ℂ] (β →₀ ℂ)) (a : α) (b : β) (c : ℂ) :
    liftSnd (α := by

  rw [liftSnd, Finsupp.lsum_single, LinearMap.toSpanSingleton_apply]
