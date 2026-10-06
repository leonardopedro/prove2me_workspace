-- Generated from ChapterGaugeUnconstrainedSpectrum.lean — theorem BookProof.ChapterGaugeUnconstrainedSpectrum.isUnconstrained_of_faithful
import Mathlib
import Definitions.Def_ChapterGaugeUnconstrainedSpectrum
open BookProof.ChapterGaugeUnconstrainedSpectrum

variable {X : Type*}
variable {G : Type*} [Group G]




theorem BookProof.ChapterGaugeUnconstrainedSpectrum.isUnconstrained_of_faithful {ρ : G →* Equiv.Perm X}
    (hρ : Function.Injective ρ) :
    IsUnconstrainedGaugeFixing (fun g => permOp (ρ g)) := by sorry
