-- Generated from ChapterGaugeUnconstrainedSpectrum.lean — solution of BookProof.ChapterGaugeUnconstrainedSpectrum.shift_observableSpectrum_subsingleton
import Mathlib
import Definitions.Def_ChapterGaugeUnconstrainedSpectrum
open BookProof.ChapterGaugeUnconstrainedSpectrum




variable {X : Type*}

variable {X : Type*}
variable {G : Type*} [Group G]

set_option maxHeartbeats 1000000 in
theorem solution :
    Subsingleton (observableSpectrum shiftPerm) := by

  constructor
  refine Quotient.ind₂ (fun k l => ?_)
  refine Quotient.sound ⟨Multiplicative.ofAdd (l - k), ?_⟩
  simp only [shiftPerm_apply]
  change k + (l - k) = l
  omega
