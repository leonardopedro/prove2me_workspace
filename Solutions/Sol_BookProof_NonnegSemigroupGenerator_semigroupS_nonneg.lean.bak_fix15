-- Generated from ChapterNonnegSemigroupGenerator.lean — solution of BookProof.NonnegSemigroupGenerator.semigroupS_nonneg
import Mathlib
import Definitions.Def_ChapterNonnegSemigroupGenerator
import Theorems.Thm_BookProof_NonnegSemigroupGenerator_expNeg_nonneg
import Theorems.Thm_BookProof_NonnegSemigroup_isSelfAdjoint_semigroupS
open BookProof.NonnegSemigroupGenerator




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open BookProof.NonnegResolvent BookProof.NonnegUnitaryGroup BookProof.NonnegSemigroup
open Filter Topology NormedSpace

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) {t : ℝ} (ht : 0 ≤ t) :
    0 ≤ semigroupS hT hsv ht := by

  rw [ContinuousLinearMap.nonneg_iff_isPositive]
  refine ⟨ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.1 (isSelfAdjoint_semigroupS hT hsv ht),
    fun x => ?_⟩
  have hlim : Tendsto (fun n : ℕ => (inner ℂ (approxS hT n t x) x : ℂ)) atTop
      (𝓝 (inner ℂ (semigroupS hT hsv ht x) x : ℂ)) :=
    (tendsto_semigroupS hT hsv ht x).inner (𝕜 := ℂ) tendsto_const_nhds
  have hre : Tendsto (fun n : ℕ => (inner ℂ (approxS hT n t x) x : ℂ).re) atTop
      (𝓝 (inner ℂ (semigroupS hT hsv ht x) x : ℂ).re) :=
    (Complex.continuous_re.tendsto _).comp hlim
  simp only [ContinuousLinearMap.reApplyInnerSelf]
  refine ge_of_tendsto' hre (fun n => ?_)
  have hpos := (ContinuousLinearMap.nonneg_iff_isPositive (approxS hT n t)).1
    (expNeg_nonneg (isSelfAdjoint_yosidaAt hT n) t)
  simpa [ContinuousLinearMap.reApplyInnerSelf] using hpos.2 x
