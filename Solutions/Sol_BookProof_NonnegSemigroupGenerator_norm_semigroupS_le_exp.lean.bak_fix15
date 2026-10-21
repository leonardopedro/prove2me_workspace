-- Generated from ChapterNonnegSemigroupGenerator.lean — solution of BookProof.NonnegSemigroupGenerator.norm_semigroupS_le_exp
import Mathlib
import Definitions.Def_ChapterNonnegSemigroupGenerator
import Theorems.Thm_BookProof_NonnegSemigroupGenerator_norm_expNeg_le_exp
import Theorems.Thm_BookProof_NonnegSemigroupGenerator_yosidaCLM_ge
open BookProof.NonnegSemigroupGenerator




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open BookProof.NonnegResolvent BookProof.NonnegUnitaryGroup BookProof.NonnegSemigroup
open Filter Topology NormedSpace

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) {lam : ℝ} (hlam : 0 ≤ lam)
    (hgap : ∀ h k : F, (h, k) ∈ T → lam * ‖h‖ ^ 2 ≤ (inner ℂ h k : ℂ).re)
    {t : ℝ} (ht : 0 ≤ t) (x : F) :
    ‖semigroupS hT hsv ht x‖ ≤ Real.exp (-(lam * t)) * ‖x‖ := by

  have hstep : ∀ n : ℕ, ‖approxS hT n t x‖
      ≤ Real.exp (-((((n : ℝ) + 1) * lam / (((n : ℝ) + 1) + lam)) * t)) * ‖x‖ := by
    intro n
    exact norm_expNeg_le_exp (yosidaAt hT n)
      (fun w => yosidaCLM_ge hT (a := (n : ℝ) + 1) (by positivity) hlam hgap w) ht x
  have hden : Tendsto (fun n : ℕ => ((n : ℝ) + 1) + lam) atTop atTop := by
    refine tendsto_atTop_mono (fun n : ℕ => ?_) tendsto_natCast_atTop_atTop
    linarith
  have hzero : Tendsto (fun n : ℕ => lam ^ 2 / (((n : ℝ) + 1) + lam)) atTop (𝓝 0) :=
    hden.const_div_atTop _
  have hmu : Tendsto (fun n : ℕ => ((n : ℝ) + 1) * lam / (((n : ℝ) + 1) + lam)) atTop (𝓝 lam) := by
    have hsub := (tendsto_const_nhds (x := lam) (f := atTop (α := ℕ))).sub hzero
    rw [sub_zero] at hsub
    refine hsub.congr (fun n => ?_)
    have hpos : (0 : ℝ) < ((n : ℝ) + 1) + lam := by positivity
    field_simp
    ring
  have hrhs : Tendsto
      (fun n : ℕ => Real.exp (-((((n : ℝ) + 1) * lam / (((n : ℝ) + 1) + lam)) * t)) * ‖x‖)
      atTop (𝓝 (Real.exp (-(lam * t)) * ‖x‖)) :=
    (Real.continuous_exp.tendsto _ |>.comp ((hmu.mul tendsto_const_nhds).neg)).mul
      tendsto_const_nhds
  exact le_of_tendsto_of_tendsto' ((tendsto_semigroupS hT hsv ht x).norm) hrhs hstep
