-- Generated from ChapterGaugeUnconstrainedSpectrum.lean — theorem BookProof.ChapterGaugeUnconstrainedSpectrum.isPhysicalFunction_iff_factors
import Mathlib
import Definitions.Def_ChapterGaugeUnconstrainedSpectrum
open BookProof.ChapterGaugeUnconstrainedSpectrum



variable {X : Type*}

variable {G : Type*} [Group G]

theorem BookProof.ChapterGaugeUnconstrainedSpectrum.isPhysicalFunction_iff_factors (ρ : G →* Equiv.Perm X) (d : X → ℂ) :
    IsPhysicalFunction ρ d ↔
      ∃ D : observableSpectrum ρ → ℂ, ∀ x : X, d x = D (Quotient.mk (orbitSetoid ρ) x) := by sorry
