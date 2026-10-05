-- Generated from ChapterSchurGershgorinGap.lean — solution of BookProof.SchurGershgorin.abs_inner_block_le
import Mathlib
import Definitions.Def_ChapterSchurGershgorinGap
import Theorems.Thm_BookProof_SchurGershgorin_exists_repr_of_mem_span_image
import Theorems.Thm_BookProof_SchurGershgorin_norm_sq_sum
import Theorems.Thm_BookProof_SchurGershgorin_inner_sum_apply_sum
open BookProof.SchurGershgorin



noncomputable section


open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.TruncationGapLift
open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs BookProof.YangMillsFockGapChain

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (b : HilbertBasis ℕ ℂ F) (H : finiteModeDomain b →ₗ[ℂ] F)
    {m : ℕ} {eps : ℝ}
    (hrow : ∀ i, i < m → ∀ S : Finset ℕ, (∀ j ∈ S, m ≤ j) →
      ∑ j ∈ S, ‖entry b H i j‖ ≤ eps)
    (hcol : ∀ j, m ≤ j → ∀ S : Finset ℕ, (∀ i ∈ S, i < m) →
      ∑ i ∈ S, ‖entry b H i j‖ ≤ eps)
    (x w : finiteModeDomain b) (hx : (x : F) ∈ galerkinSpan b m)
    (hw : (w : F) ∈ tailSpan b m) :
    ‖(inner ℂ (x : F) (H w) : ℂ)‖ ≤ eps * ‖(x : F)‖ * ‖(w : F)‖ := by

  classical
  rcases eq_or_ne ((x : F)) 0 with hx0 | hxne
  · simp [hx0]
  rcases eq_or_ne ((w : F)) 0 with hw0 | hwne
  · have hwz : w = 0 := Subtype.ext hw0
    simp [hwz]
  obtain ⟨S, cx, hSsub, hxc⟩ := exists_repr_of_mem_span_image b {i | i < m} hx
  obtain ⟨T, cw, hTsub, hwc⟩ := exists_repr_of_mem_span_image b {j | m ≤ j} hw
  have hwsum : w = ∑ j ∈ T, cw j • bvec b j := by
    refine Subtype.ext ?_
    rw [hwc]
    push_cast
    rfl
  set A : ℕ → ℕ → ℝ := fun i j => ‖entry b H i j‖ with hA
  set X : ℝ := ‖(x : F)‖ with hX
  set W : ℝ := ‖(w : F)‖ with hW
  have hXpos : 0 < X := norm_pos_iff.mpr hxne
  have hWpos : 0 < W := norm_pos_iff.mpr hwne
  have hXsq : X ^ 2 = ∑ i ∈ S, ‖cx i‖ ^ 2 := by rw [hX, hxc]; exact norm_sq_sum b S cx
  have hWsq : W ^ 2 = ∑ j ∈ T, ‖cw j‖ ^ 2 := by rw [hW, hwc]; exact norm_sq_sum b T cw
  -- the pairing, in matrix elements
  have hpair : (inner ℂ (x : F) (H w) : ℂ)
      = ∑ i ∈ S, ∑ j ∈ T, (starRingEnd ℂ) (cx i) * cw j * entry b H i j := by
    rw [hxc, hwsum]
    exact inner_sum_apply_sum b H S T cx cw
  -- the triangle inequality
  have hbound1 : ‖(inner ℂ (x : F) (H w) : ℂ)‖
      ≤ ∑ i ∈ S, ∑ j ∈ T, ‖cx i‖ * ‖cw j‖ * A i j := by
    rw [hpair]
    refine (norm_sum_le _ _).trans ?_
    refine Finset.sum_le_sum fun i _ => ?_
    refine (norm_sum_le _ _).trans ?_
    refine Finset.sum_le_sum fun j _ => ?_
    simp [hA]
  -- the two Schur sums
  set P : ℝ := ∑ i ∈ S, ∑ j ∈ T, A i j * ‖cx i‖ ^ 2 with hPdef
  set Q : ℝ := ∑ i ∈ S, ∑ j ∈ T, A i j * ‖cw j‖ ^ 2 with hQdef
  have hP : P ≤ eps * X ^ 2 := by
    rw [hPdef, hXsq, Finset.mul_sum]
    refine Finset.sum_le_sum fun i hi => ?_
    rw [← Finset.sum_mul]
    refine mul_le_mul_of_nonneg_right ?_ (sq_nonneg _)
    exact hrow i (hSsub hi) T (fun j hj => hTsub hj)
  have hQ : Q ≤ eps * W ^ 2 := by
    rw [hQdef, Finset.sum_comm, hWsq, Finset.mul_sum]
    refine Finset.sum_le_sum fun j hj => ?_
    rw [← Finset.sum_mul]
    refine mul_le_mul_of_nonneg_right ?_ (sq_nonneg _)
    exact hcol j (hTsub hj) S (fun i hi => hSsub hi)
  -- the weighted arithmetic–geometric mean, with the optimal weight
  set t : ℝ := W / X with ht
  have htpos : 0 < t := div_pos hWpos hXpos
  set t2 : ℝ := t / 2 with ht2
  set s2 : ℝ := t⁻¹ / 2 with hs2
  have hterm : ∀ i j, ‖cx i‖ * ‖cw j‖ * A i j
      ≤ t2 * (A i j * ‖cx i‖ ^ 2) + s2 * (A i j * ‖cw j‖ ^ 2) := by
    intro i j
    have hA0 : 0 ≤ A i j := norm_nonneg _
    have hkey : 2 * (‖cx i‖ * ‖cw j‖) ≤ t * ‖cx i‖ ^ 2 + t⁻¹ * ‖cw j‖ ^ 2 := by
      have h0 : 0 ≤ (t * ‖cx i‖ - ‖cw j‖) ^ 2 := sq_nonneg _
      have hid : t * (t * ‖cx i‖ ^ 2 + t⁻¹ * ‖cw j‖ ^ 2 - 2 * (‖cx i‖ * ‖cw j‖))
          = (t * ‖cx i‖ - ‖cw j‖) ^ 2 := by
        field_simp
        ring
      nlinarith [htpos, h0, hid]
    have hmul := mul_le_mul_of_nonneg_left hkey hA0
    rw [ht2, hs2]
    nlinarith [hmul]
  have hsum : ∑ i ∈ S, ∑ j ∈ T, ‖cx i‖ * ‖cw j‖ * A i j
      ≤ ∑ i ∈ S, ∑ j ∈ T, (t2 * (A i j * ‖cx i‖ ^ 2) + s2 * (A i j * ‖cw j‖ ^ 2)) :=
    Finset.sum_le_sum fun i _ => Finset.sum_le_sum fun j _ => hterm i j
  have hsplit : ∑ i ∈ S, ∑ j ∈ T, (t2 * (A i j * ‖cx i‖ ^ 2) + s2 * (A i j * ‖cw j‖ ^ 2))
      = t2 * P + s2 * Q := by
    rw [hPdef, hQdef, Finset.mul_sum, Finset.mul_sum, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [Finset.mul_sum, Finset.mul_sum, ← Finset.sum_add_distrib]
  have hfinal : t2 * (eps * X ^ 2) + s2 * (eps * W ^ 2) = eps * X * W := by
    rw [ht2, hs2, ht]
    field_simp
    ring
  have hlast : t2 * P + s2 * Q ≤ eps * X * W := by
    rw [← hfinal]
    have h1 : t2 * P ≤ t2 * (eps * X ^ 2) :=
      mul_le_mul_of_nonneg_left hP (by positivity)
    have h2 : s2 * Q ≤ s2 * (eps * W ^ 2) :=
      mul_le_mul_of_nonneg_left hQ (by positivity)
    linarith
  calc ‖(inner ℂ (x : F) (H w) : ℂ)‖
      ≤ ∑ i ∈ S, ∑ j ∈ T, ‖cx i‖ * ‖cw j‖ * A i j := hbound1
    _ ≤ ∑ i ∈ S, ∑ j ∈ T, (t2 * (A i j * ‖cx i‖ ^ 2) + s2 * (A i j * ‖cw j‖ ^ 2)) := hsum
    _ = t2 * P + s2 * Q := hsplit
    _ ≤ eps * X * W := hlast
