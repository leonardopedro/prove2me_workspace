-- Generated from ChapterGradedFock.lean — solution of BookProof.GradedFock.otimes_single
import Mathlib
import Definitions.Def_ChapterGradedFock
open BookProof.GradedFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FockSecondQuantization BookProof.FermionFock
open BookProof.ChapterSuperBracket

noncomputable section

variable {α β : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (a : α) (b : β) (x y : ℂ) :
    otimes (Finsupp.single a x) (Finsupp.single b y) = Finsupp.single (a, b) (x * y) := by

  ext p
  obtain ⟨a', b'⟩ := p
  simp only [otimes_apply]
  by_cases h1 : a = a' <;> by_cases h2 : b = b' <;> simp [h1, h2]
