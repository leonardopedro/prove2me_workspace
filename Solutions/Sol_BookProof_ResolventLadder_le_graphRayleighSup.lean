-- Generated from ChapterResolventMinMaxLadder.lean — solution of BookProof.ResolventLadder.le_graphRayleighSup
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Theorems.Thm_BookProof_ResolventLadder_inv_sub_one_le_of_rayleigh_le
import Theorems.Thm_BookProof_ResolventLadder_exists_unit_rayleigh_lt
import Theorems.Thm_BookProof_ResolventLadder_graphRayleighSup_nonneg
import Theorems.Thm_BookProof_ResolventLadder_graphRayleighSet_bddAbove
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
theorem solution (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) {S : Submodule ℂ F} {k : ℕ}
    (hrank : Module.finrank ℂ S = k + 1) (hdom : InDomain T S) :
    1 / maxminLevel (res hT) k - 1 ≤ graphRayleighSup T S := by

  have hfd : FiniteDimensional ℂ S := .of_finrank_pos (by rw [hrank]; omega)
  have hbdd := graphRayleighSet_bddAbove hsv hdom
  have hsupnn := graphRayleighSup_nonneg hT S
  rcases le_or_gt (maxminLevel (res hT) k) 0 with hν | hν
  · have h1 : 1 / maxminLevel (res hT) k ≤ 0 := by
      rcases eq_or_lt_of_le hν with h | h
      · rw [h]; simp
      · exact (one_div_neg.mpr h).le
    linarith
  · refine le_of_forall_pos_le_add fun δ hδ => ?_
    set ν := maxminLevel (res hT) k with hνdef
    have hε : 0 < δ * ν ^ 2 := by positivity
    obtain ⟨y, hyS, hy1, hlt⟩ := exists_unit_rayleigh_lt (res hT) hrank hε
    obtain ⟨z, hz⟩ := hdom y hyS
    have hc : 0 < ν + δ * ν ^ 2 := by nlinarith
    have hle := inv_sub_one_le_of_rayleigh_le hT hz hy1 hc hlt.le
    have hmem : (inner ℂ y z : ℂ).re ∈ graphRayleighSet T S := ⟨y, z, hz, hyS, hy1, rfl⟩
    have hsup : (inner ℂ y z : ℂ).re ≤ graphRayleighSup T S := le_csSup hbdd hmem
    have harith : 1 / ν ≤ 1 / (ν + δ * ν ^ 2) + δ := by
      rw [div_add' _ _ _ (ne_of_gt hc), div_le_div_iff₀ hν hc]
      nlinarith
    linarith
