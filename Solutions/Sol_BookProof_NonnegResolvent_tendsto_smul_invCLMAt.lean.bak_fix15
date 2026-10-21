-- Generated from ChapterNonnegResolvent.lean — solution of BookProof.NonnegResolvent.tendsto_smul_invCLMAt
import Mathlib
import Definitions.Def_ChapterNonnegResolvent
import Theorems.Thm_BookProof_NonnegResolvent_norm_smul_invCLMAt_le
import Theorems.Thm_BookProof_NonnegResolvent_norm_smul_invCLMAt_sub_le
import Theorems.Thm_BookProof_NonnegResolvent_dense_domain
open BookProof.NonnegResolvent




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) (h : F) {ε : ℝ} (hε : 0 < ε) :
    ∃ A : ℝ, 0 < A ∧ ∀ (c : ℝ) (hc : 0 < c), A ≤ c →
      ‖(c : ℂ) • invCLMAt hT hc h - h‖ < ε := by

  have hdense := dense_domain hT hsv
  have hmem : h ∈ closure ((T.map (LinearMap.fst ℂ F F) : Set F)) := hdense h
  obtain ⟨u, hu, hdist⟩ := Metric.mem_closure_iff.1 hmem (ε / 3) (by linarith)
  obtain ⟨p, hp, hp1⟩ := Submodule.mem_map.1 hu
  refine ⟨max 1 (4 * ‖p.2‖ / ε), lt_of_lt_of_le one_pos (le_max_left _ _), ?_⟩
  intro c hc hcA
  have hc3 : 4 * ‖p.2‖ / ε ≤ c := le_trans (le_max_right _ _) hcA
  have hpu : (u, p.2) ∈ T := by
    have : p = (u, p.2) := by
      rw [← hp1]
      simp
    rwa [← this]
  have hdec : (c : ℂ) • invCLMAt hT hc h - h
      = (c : ℂ) • invCLMAt hT hc (h - u) + ((c : ℂ) • invCLMAt hT hc u - u) + (u - h) := by
    rw [map_sub, smul_sub]
    abel
  have hb1 : ‖(c : ℂ) • invCLMAt hT hc (h - u)‖ ≤ ‖h - u‖ :=
    norm_smul_invCLMAt_le hT hc (h - u)
  have hb2 : ‖(c : ℂ) • invCLMAt hT hc u - u‖ ≤ c⁻¹ * ‖p.2‖ :=
    norm_smul_invCLMAt_sub_le hT hc hpu
  have hhu : ‖h - u‖ < ε / 3 := by
    rw [← dist_eq_norm]
    exact hdist
  have huh : ‖u - h‖ < ε / 3 := by
    rw [norm_sub_rev]
    exact hhu
  have hb2' : c⁻¹ * ‖p.2‖ < ε / 3 := by
    rcases eq_or_lt_of_le (norm_nonneg p.2) with hz | hz
    · rw [← hz, mul_zero]
      linarith
    · have hcpos : 0 < c := hc
      rw [inv_mul_eq_div, div_lt_iff₀ hcpos]
      have h3 : 4 * ‖p.2‖ ≤ c * ε := by
        rw [div_le_iff₀ hε] at hc3
        linarith
      linarith
  calc ‖(c : ℂ) • invCLMAt hT hc h - h‖
      ≤ ‖(c : ℂ) • invCLMAt hT hc (h - u) + ((c : ℂ) • invCLMAt hT hc u - u)‖ + ‖u - h‖ := by
        rw [hdec]
        exact norm_add_le _ _
    _ ≤ ‖(c : ℂ) • invCLMAt hT hc (h - u)‖ + ‖(c : ℂ) • invCLMAt hT hc u - u‖ + ‖u - h‖ := by
        gcongr
        exact norm_add_le _ _
    _ < ε := by
        linarith [hb1.trans_lt hhu, hb2.trans_lt hb2', huh]
