-- Generated from ChapterNonnegSemigroupGenerator.lean — solution of BookProof.NonnegSemigroupGenerator.tendsto_semigroupS_difference_quotient
import Mathlib
import Definitions.Def_ChapterNonnegSemigroupGenerator
import Theorems.Thm_BookProof_NonnegSemigroupGenerator_norm_semigroupS_sub_add_smul_le
import Theorems.Thm_BookProof_NonnegResolvent_dense_domain
open BookProof.NonnegSemigroupGenerator




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open BookProof.NonnegResolvent BookProof.NonnegUnitaryGroup BookProof.NonnegSemigroup
open Filter Topology NormedSpace

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) {h k : F} (hk : (h, k) ∈ T) {ε : ℝ} (hε : 0 < ε) :
    ∃ δ > 0, ∀ (t : ℝ) (ht : 0 < t), t < δ →
      ‖t⁻¹ • (semigroupS hT hsv ht.le h - h) + k‖ < ε := by

  obtain ⟨z, hz, hkz⟩ := (dense_domain hT hsv).exists_dist_lt k (ε := ε / 8) (by linarith)
  obtain ⟨p, hp, hp1⟩ := Submodule.mem_map.1 hz
  have hpy : (z, p.2) ∈ T := by
    have hpe : p = (z, p.2) := by rw [← hp1]; simp
    rwa [← hpe]
  have hkz' : ‖k - z‖ ≤ ε / 8 := by
    rw [← dist_eq_norm]
    exact hkz.le
  refine ⟨ε / (2 * (‖p.2‖ + 1)), by positivity, fun t ht htδ => ?_⟩
  have hmain := norm_semigroupS_sub_add_smul_le hT hsv hk hpy hkz' ht.le
  have hrw : t⁻¹ • (semigroupS hT hsv ht.le h - h) + k
      = t⁻¹ • (semigroupS hT hsv ht.le h - h + t • k) := by
    rw [smul_add, smul_smul, inv_mul_cancel₀ ht.ne', one_smul]
  have hnorm : ‖(t⁻¹ : ℝ)‖ = t⁻¹ := by
    rw [Real.norm_eq_abs, abs_of_pos (inv_pos.2 ht)]
  have htp : 0 < ‖p.2‖ + 1 := by positivity
  have hsmall : t * ‖p.2‖ < ε / 2 := by
    have h1 : t < ε / (2 * (‖p.2‖ + 1)) := htδ
    rw [lt_div_iff₀ (by positivity)] at h1
    nlinarith [norm_nonneg p.2]
  rw [hrw, norm_smul, hnorm]
  have hb : t⁻¹ * ‖semigroupS hT hsv ht.le h - h + t • k‖
      ≤ t⁻¹ * (t * (2 * (ε / 8) + t * ‖p.2‖)) := by
    have : (0 : ℝ) ≤ t⁻¹ := (inv_pos.2 ht).le
    exact mul_le_mul_of_nonneg_left hmain this
  have heq : t⁻¹ * (t * (2 * (ε / 8) + t * ‖p.2‖)) = 2 * (ε / 8) + t * ‖p.2‖ := by
    field_simp
  rw [heq] at hb
  linarith
