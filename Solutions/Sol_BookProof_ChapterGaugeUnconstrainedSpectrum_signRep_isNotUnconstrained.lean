-- Generated from ChapterGaugeUnconstrainedSpectrum.lean — solution of BookProof.ChapterGaugeUnconstrainedSpectrum.signRep_isNotUnconstrained
import Mathlib
import Definitions.Def_ChapterGaugeUnconstrainedSpectrum
open BookProof.ChapterGaugeUnconstrainedSpectrum




variable {X : Type*}

variable {X : Type*}
variable {G : Type*} [Group G]

set_option maxHeartbeats 1000000 in
theorem solution : ¬ IsUnconstrainedGaugeFixing signRep := by

  intro h
  exact h (Multiplicative.ofAdd 1) (by
    intro hm
    have : Multiplicative.toAdd (Multiplicative.ofAdd (1 : ℤ)) = 0 := by
      rw [hm]; rfl
    simp at this) ⟨_, rfl⟩
