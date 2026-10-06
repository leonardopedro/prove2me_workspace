-- Generated from ChapterGaugeUnconstrainedSpectrum.lean — solution of BookProof.ChapterGaugeUnconstrainedSpectrum.isUnconstrained_of_faithful
import Mathlib
import Definitions.Def_ChapterGaugeUnconstrainedSpectrum
import Theorems.Thm_BookProof_ChapterGaugeUnconstrainedSpectrum_permOp_isFunctionOfSpectrum_iff
open BookProof.ChapterGaugeUnconstrainedSpectrum




variable {X : Type*}

variable {X : Type*}
variable {G : Type*} [Group G]

set_option maxHeartbeats 1000000 in
theorem solution {ρ : G →* Equiv.Perm X}
    (hρ : Function.Injective ρ) :
    IsUnconstrainedGaugeFixing (fun g => permOp (ρ g)) := by

  intro g hg hmem
  exact hg (hρ (by simpa using (permOp_isFunctionOfSpectrum_iff (ρ g)).1 hmem))
