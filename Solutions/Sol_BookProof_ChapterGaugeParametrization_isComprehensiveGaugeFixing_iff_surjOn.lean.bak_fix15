-- Generated from ChapterGaugeParametrization.lean — solution of BookProof.ChapterGaugeParametrization.isComprehensiveGaugeFixing_iff_surjOn
import Mathlib
import Definitions.Def_ChapterGaugeParametrization
import Theorems.Thm_BookProof_ChapterGaugeParametrization_apply_eq
import Theorems.Thm_BookProof_ChapterGaugeParametrization_orbit_eq_fiber
open BookProof.ChapterGaugeParametrization




open BookProof.ChapterGaugeIncompleteFixing

variable {X Y : Type*}

variable {X Y : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (π : X → Y) (S : Set X) :
    IsComprehensiveGaugeFixing (fiberGauge π) S ↔ ∀ x : X, ∃ s ∈ S, π s = π x := by

  constructor
  · intro hS x
    obtain ⟨s, hsS, σ, hσ⟩ := hS x
    exact ⟨s, hsS, by rw [← hσ, apply_eq π σ s]⟩
  · intro hS x
    obtain ⟨s, hsS, hs⟩ := hS x
    have hmem : x ∈ MulAction.orbit (fiberGauge π) s := by
      rw [orbit_eq_fiber]
      exact hs.symm
    obtain ⟨σ, hσ⟩ := hmem
    exact ⟨s, hsS, σ, hσ⟩
