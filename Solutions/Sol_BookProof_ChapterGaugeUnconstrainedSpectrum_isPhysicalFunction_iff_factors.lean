-- Generated from ChapterGaugeUnconstrainedSpectrum.lean — solution of BookProof.ChapterGaugeUnconstrainedSpectrum.isPhysicalFunction_iff_factors
import Mathlib
import Definitions.Def_ChapterGaugeUnconstrainedSpectrum
open BookProof.ChapterGaugeUnconstrainedSpectrum




variable {X : Type*}

variable {X : Type*}
variable {G : Type*} [Group G]

set_option maxHeartbeats 1000000 in
theorem solution (ρ : G →* Equiv.Perm X) (d : X → ℂ) :
    IsPhysicalFunction ρ d ↔
      ∃ D : observableSpectrum ρ → ℂ, ∀ x : X, d x = D (Quotient.mk (orbitSetoid ρ) x) := by

  constructor
  · intro hd
    refine ⟨Quotient.lift d ?_, fun x => rfl⟩
    rintro x y ⟨g, rfl⟩
    exact (hd g x).symm
  · rintro ⟨D, hD⟩ g x
    rw [hD (ρ g x), hD x]
    exact congrArg D (Quotient.sound ⟨g⁻¹, by rw [map_inv]; simp⟩)
