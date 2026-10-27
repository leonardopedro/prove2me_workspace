-- Generated from ChapterNonnegSemigroupGenerator.lean — solution of BookProof.NonnegSemigroupGenerator.norm_semigroupS_sub_add_smul_le
import Mathlib
import Definitions.Def_ChapterNonnegSemigroupGenerator
import Theorems.Thm_BookProof_NonnegSemigroupGenerator_norm_expNeg_sub_add_smul_le
import Theorems.Thm_BookProof_NonnegResolvent_norm_yosidaCLM_le_of_mem
import Theorems.Thm_BookProof_NonnegResolvent_tendsto_yosidaAt
import Theorems.Thm_BookProof_NonnegSemigroup_norm_expNeg_sub_self_le
open BookProof.NonnegSemigroupGenerator




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open BookProof.NonnegResolvent BookProof.NonnegUnitaryGroup BookProof.NonnegSemigroup
open Filter Topology NormedSpace

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) {h k : F} (hk : (h, k) ∈ T)
    {k' k'' : F} (hk' : (k', k'') ∈ T) {ε : ℝ} (hkk' : ‖k - k'‖ ≤ ε) {t : ℝ} (ht : 0 ≤ t) :
    ‖semigroupS hT hsv ht h - h + t • k‖ ≤ t * (2 * ε + t * ‖k''‖) := by

  have hstep : ∀ n : ℕ, ‖approxS hT n t h - h + t • k‖
      ≤ t * (‖k - yosidaAt hT n h‖ + (2 * ε + t * ‖k''‖)) := by
    intro n
    refine norm_expNeg_sub_add_smul_le (yosidaAt_nonneg hT n) ht h k ?_
    intro s hs
    have hA := yosidaAt_nonneg hT n
    have h1 : ‖expNeg (yosidaAt hT n) s (k - k')‖ ≤ ‖k - k'‖ :=
      norm_expNeg_le _ hA hs.1 _
    have h2 : ‖expNeg (yosidaAt hT n) s k' - k'‖ ≤ s * ‖yosidaAt hT n k'‖ :=
      norm_expNeg_sub_self_le _ hA hs.1 k'
    have h3 : ‖yosidaAt hT n k'‖ ≤ ‖k''‖ :=
      norm_yosidaCLM_le_of_mem hT (a := (n : ℝ) + 1) (by positivity) hk'
    have hdec : expNeg (yosidaAt hT n) s k - k
        = expNeg (yosidaAt hT n) s (k - k') + (expNeg (yosidaAt hT n) s k' - k') + (k' - k) := by
      rw [map_sub]; abel
    have h4 : ‖k' - k‖ ≤ ε := by rw [norm_sub_rev]; exact hkk'
    have h5 : s * ‖yosidaAt hT n k'‖ ≤ t * ‖k''‖ := by
      have := hs.2
      have hnn : (0 : ℝ) ≤ ‖yosidaAt hT n k'‖ := norm_nonneg _
      nlinarith [norm_nonneg k'', hs.1]
    calc ‖expNeg (yosidaAt hT n) s k - k‖
        ≤ ‖expNeg (yosidaAt hT n) s (k - k') + (expNeg (yosidaAt hT n) s k' - k')‖
            + ‖k' - k‖ := by rw [hdec]; exact norm_add_le _ _
      _ ≤ ‖expNeg (yosidaAt hT n) s (k - k')‖ + ‖expNeg (yosidaAt hT n) s k' - k'‖
            + ‖k' - k‖ := by gcongr; exact norm_add_le _ _
      _ ≤ 2 * ε + t * ‖k''‖ := by
          have := h1.trans hkk'
          linarith [h2.trans h5]
  have hlim : Tendsto (fun n : ℕ => ‖approxS hT n t h - h + t • k‖) atTop
      (𝓝 ‖semigroupS hT hsv ht h - h + t • k‖) :=
    (((tendsto_semigroupS hT hsv ht h).sub tendsto_const_nhds).add tendsto_const_nhds).norm
  have hrhs : Tendsto (fun n : ℕ => t * (‖k - yosidaAt hT n h‖ + (2 * ε + t * ‖k''‖))) atTop
      (𝓝 (t * (0 + (2 * ε + t * ‖k''‖)))) := by
    have hy : Tendsto (fun n : ℕ => ‖k - yosidaAt hT n h‖) atTop (𝓝 0) := by
      have := (tendsto_const_nhds (x := k) (f := atTop (α := ℕ))).sub
        (tendsto_yosidaAt hT hsv hk)
      simpa using this.norm
    exact ((hy.add tendsto_const_nhds).const_mul t)
  have := le_of_tendsto_of_tendsto' hlim hrhs hstep
  simpa using this
