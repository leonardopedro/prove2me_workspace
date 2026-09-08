-- Generated from ChapterYangMillsFriedrichs.lean — solution of BookProof.YangMillsFriedrichs.form_closable
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichs
import Theorems.Thm_BookProof_YangMillsFriedrichs_formNormSq_nonneg
import Theorems.Thm_BookProof_YangMillsFriedrichs_formInner_add_right
import Theorems.Thm_BookProof_YangMillsFriedrichs_re_formInner_sq_le
import Theorems.Thm_BookProof_YangMillsFriedrichs_formNormSq_add_le
open BookProof.YangMillsFriedrichs



















open BookProof.FarisLavine




variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution {H : D →ₗ[ℂ] F} (hsym : SymmetricOn D H)
    (hpos : ∀ x : D, 0 ≤ quadForm H x) (x : ℕ → D)
    (hCauchy : ∀ ε > 0, ∃ N : ℕ, ∀ p ≥ N, ∀ q ≥ N, formNormSq H (x p - x q) < ε)
    (hzero : Filter.Tendsto (fun n => ((x n : F))) Filter.atTop (nhds 0)) :
    Filter.Tendsto (fun n => formNormSq H (x n)) Filter.atTop (nhds 0) := by

  -- the form norms are bounded
  obtain ⟨N₀, hN₀⟩ := hCauchy 1 one_pos
  set Cbd : ℝ := 2 * 1 + 2 * formNormSq H (x N₀) with hCbd
  have hbdd : ∀ n ≥ N₀, formNormSq H (x n) ≤ Cbd := by
    intro n hn
    have hsplit : x n = (x n - x N₀) + x N₀ := by abel
    have := formNormSq_add_le hsym hpos (x n - x N₀) (x N₀)
    rw [← hsplit] at this
    have h1 : formNormSq H (x n - x N₀) < 1 := hN₀ n hn N₀ le_rfl
    rw [hCbd]
    linarith
  have hCbdnn : 0 ≤ Cbd := by
    have := formNormSq_nonneg hpos (x N₀)
    rw [hCbd]; linarith
  rw [Metric.tendsto_atTop]
  intro ε hε
  -- choose the form-Cauchy threshold
  set δ : ℝ := (ε / 2) ^ 2 / (Cbd + 1) with hδ
  have hδpos : 0 < δ := by
    rw [hδ]; positivity
  obtain ⟨N₁, hN₁⟩ := hCauchy δ hδpos
  refine ⟨max N₀ N₁, fun n hn => ?_⟩
  have hn0 : N₀ ≤ n := le_trans (le_max_left _ _) hn
  have hn1 : N₁ ≤ n := le_trans (le_max_right _ _) hn
  have hnn : 0 ≤ formNormSq H (x n) := formNormSq_nonneg hpos _
  -- the key estimate: `q(xₙ) ≤ ε/2 + Re⟪xₙ, x_m⟫_H` for every large `m`
  have hkey : ∀ m ≥ max N₀ N₁, formNormSq H (x n) - ε / 2 ≤ (formInner H (x n) (x m)).re := by
    intro m hm
    have hm0 : N₀ ≤ m := le_trans (le_max_left _ _) hm
    have hm1 : N₁ ≤ m := le_trans (le_max_right _ _) hm
    have hsplit : formInner H (x n) (x n) = formInner H (x n) (x n - x m)
        + formInner H (x n) (x m) := by
      rw [← formInner_add_right]
      congr 1
      abel
    have hre : formNormSq H (x n)
        = (formInner H (x n) (x n - x m)).re + (formInner H (x n) (x m)).re := by
      simp only [formNormSq, hsplit, Complex.add_re]
    have hCS := re_formInner_sq_le hsym hpos (x n) (x n - x m)
    have hlt : formNormSq H (x n - x m) < δ := hN₁ n hn1 m hm1
    have hbn : formNormSq H (x n) ≤ Cbd := hbdd n hn0
    have hprod : (formInner H (x n) (x n - x m)).re ^ 2 ≤ Cbd * δ := by
      refine le_trans hCS ?_
      have h1 : 0 ≤ formNormSq H (x n - x m) := formNormSq_nonneg hpos _
      nlinarith
    have hεδ : Cbd * δ ≤ (ε / 2) ^ 2 := by
      rw [hδ]
      rw [mul_div_assoc'] at *
      rw [div_le_iff₀ (by linarith : (0:ℝ) < Cbd + 1)]
      nlinarith [sq_nonneg (ε / 2)]
    have habs : |(formInner H (x n) (x n - x m)).re| ≤ ε / 2 := by
      have h2 : (formInner H (x n) (x n - x m)).re ^ 2 ≤ (ε / 2) ^ 2 := le_trans hprod hεδ
      nlinarith [abs_nonneg ((formInner H (x n) (x n - x m)).re),
        sq_abs ((formInner H (x n) (x n - x m)).re), hε]
    rw [hre]
    linarith [(abs_le.mp habs).2]
  -- let `m → ∞`: the right-hand side tends to `0` by symmetry of `H`
  have hlim : Filter.Tendsto (fun m => (formInner H (x n) (x m)).re) Filter.atTop (nhds 0) := by
    have hform : ∀ m, formInner H (x n) (x m)
        = inner ℂ ((x n : F) + H (x n)) ((x m : F)) := by
      intro m
      simp only [formInner, inner_add_left]
      congr 1
      exact (hsym (x n) (x m)).symm
    have hcont : Filter.Tendsto
        (fun m => (inner ℂ ((x n : F) + H (x n)) ((x m : F)) : ℂ)) Filter.atTop (nhds 0) := by
      have := ((innerSL ℂ ((x n : F) + H (x n))).continuous.tendsto 0).comp hzero
      simpa using this
    have := (Complex.continuous_re.tendsto 0).comp hcont
    simpa [hform] using this
  have hle : formNormSq H (x n) - ε / 2 ≤ 0 := by
    refine ge_of_tendsto hlim ?_
    filter_upwards [Filter.eventually_ge_atTop (max N₀ N₁)] with m hm
    exact hkey m hm
  rw [Real.dist_eq, sub_zero, abs_of_nonneg hnn]
  linarith
