-- Generated from ChapterGaugeUnconstrainedSpectrum.lean — solution of BookProof.ChapterGaugeUnconstrainedSpectrum.shiftPerm_movesEveryPoint
import Mathlib
import Definitions.Def_ChapterGaugeUnconstrainedSpectrum
open BookProof.ChapterGaugeUnconstrainedSpectrum




variable {X : Type*}

variable {X : Type*}
variable {G : Type*} [Group G]

set_option maxHeartbeats 1000000 in
theorem solution (m : Multiplicative ℤ) (hm : m ≠ 1) (k : ℤ) :
    shiftPerm m k ≠ k := by

  have hm' : Multiplicative.toAdd m ≠ 0 := fun h => hm (by
    apply Multiplicative.toAdd.injective
    simpa using h)
  simp only [shiftPerm_apply]
  omega
