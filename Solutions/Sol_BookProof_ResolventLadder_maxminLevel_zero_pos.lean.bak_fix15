-- Generated from ChapterResolventMinMaxLadder.lean — solution of BookProof.ResolventLadder.maxminLevel_zero_pos
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Theorems.Thm_BookProof_ResolventLadder_normSq_sq_le_rayleigh_mul
import Theorems.Thm_BookProof_ResolventLadder_res_isSelfAdjoint
import Theorems.Thm_BookProof_ResolventLadder_res_re_inner_nonneg
import Theorems.Thm_BookProof_ResolventLadder_res_injective
import Theorems.Thm_BookProof_ResolventLadder_rayleighInfOn_le_maxminLevel
import Theorems.Thm_BookProof_ResolventLadder_rayleighInfOn_span_singleton
open BookProof.ResolventLadder



noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution [Nontrivial F] (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) : 0 < maxminLevel (res hT) 0 := by

  obtain ⟨x0, hx0⟩ := exists_ne (0 : F)
  set x : F := ‖x0‖⁻¹ • x0 with hxdef
  have hx1 : ‖x‖ = 1 := by
    rw [hxdef, norm_smul]
    simp [norm_ne_zero_iff.mpr hx0]
  have hxne : x ≠ 0 := by
    intro h
    rw [h] at hx1
    simp at hx1
  have hpos : 0 < rayleighVal (res hT) x := by
    rcases eq_or_lt_of_le (res_re_inner_nonneg hT x) with h | h
    · exfalso
      have hmain := normSq_sq_le_rayleigh_mul (res_isSelfAdjoint hT) (res_re_inner_nonneg hT) x
      rw [← h, zero_mul] at hmain
      have hzero : res hT x = 0 := by
        have h4 : ‖res hT x‖ ^ 4 = 0 := le_antisymm hmain (by positivity)
        exact norm_eq_zero.mp ((pow_eq_zero_iff (n := 4) (by norm_num)).mp h4)
      exact hxne (res_injective hT hsv (by rw [hzero, map_zero] : res hT x = res hT 0))
    · exact h
  have hle : rayleighInfOn (res hT) (Submodule.span ℂ {x}) ≤ maxminLevel (res hT) 0 :=
    rayleighInfOn_le_maxminLevel (res hT) (by simpa using finrank_span_singleton hxne)
  rw [rayleighInfOn_span_singleton (res hT) hx1] at hle
  linarith
