-- Generated from ChapterResolventMinMaxEquality.lean — solution of BookProof.ResolventLadderEq.exists_unit_mem_ker_of_no_range_subspace
import Mathlib
import Definitions.Def_ChapterResolventMinMaxEquality
open BookProof.ResolventLadderEq



noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.MinMaxSpectrum
open BookProof.ResolventLadder
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (P : F →L[ℂ] F) {k : ℕ}
    (hex : ¬ ∃ S₀ : Submodule ℂ F,
      Module.finrank ℂ S₀ = k + 1 ∧ (S₀ : Set F) ⊆ Set.range P)
    {W : Submodule ℂ F} (hW : Module.finrank ℂ W = k + 1) :
    ∃ x ∈ W, ‖x‖ = 1 ∧ P x = 0 := by

  classical
  by_contra hcon
  push_neg at hcon
  -- no unit vector of `W` is killed, hence no non-zero vector is
  have hinj : Function.Injective ((P : F →ₗ[ℂ] F).domRestrict W) := by
    rw [← LinearMap.ker_eq_bot]
    refine (Submodule.eq_bot_iff _).mpr ?_
    rintro ⟨x, hxW⟩ hx
    have hPx : P x = 0 := by simpa using hx
    by_contra hne
    have hx0 : x ≠ 0 := by
      intro h
      exact hne (Subtype.ext (by simpa using h))
    have hnorm : ‖x‖ ≠ 0 := norm_ne_zero_iff.mpr hx0
    have hmem : (‖x‖⁻¹ : ℂ) • x ∈ W := W.smul_mem _ hxW
    have hunit : ‖(‖x‖⁻¹ : ℂ) • x‖ = 1 := by
      rw [norm_smul]
      simp [hnorm]
    have := hcon _ hmem hunit
    exact this (by rw [ContinuousLinearMap.map_smul, hPx, smul_zero])
  refine hex ⟨W.map (P : F →ₗ[ℂ] F), ?_, ?_⟩
  · have hrange : LinearMap.range ((P : F →ₗ[ℂ] F).domRestrict W) = W.map (P : F →ₗ[ℂ] F) :=
      LinearMap.range_domRestrict _ _
    rw [← hrange, LinearMap.finrank_range_of_inj hinj, hW]
  · rintro x hx
    obtain ⟨w, -, rfl⟩ := Submodule.mem_map.mp hx
    exact ⟨w, rfl⟩
