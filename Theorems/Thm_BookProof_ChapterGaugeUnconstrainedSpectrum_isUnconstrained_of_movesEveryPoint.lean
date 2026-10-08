-- Generated from ChapterGaugeUnconstrainedSpectrum.lean — theorem BookProof.ChapterGaugeUnconstrainedSpectrum.isUnconstrained_of_movesEveryPoint
import Mathlib
import Definitions.Def_ChapterGaugeUnconstrainedSpectrum
open BookProof.ChapterGaugeUnconstrainedSpectrum



variable {X : Type*}

variable {G : Type*} [Group G]

theorem BookProof.ChapterGaugeUnconstrainedSpectrum.isUnconstrained_of_movesEveryPoint [Nonempty X]
    {ρ : G →* Equiv.Perm X} (hmoves : ∀ g : G, g ≠ 1 → ∀ x : X, ρ g x ≠ x) :
    IsUnconstrainedGaugeFixing (fun g => permOp (ρ g)) := by sorry
