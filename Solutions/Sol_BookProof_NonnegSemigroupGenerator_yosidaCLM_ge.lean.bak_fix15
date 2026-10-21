-- Generated from ChapterNonnegSemigroupGenerator.lean — solution of BookProof.NonnegSemigroupGenerator.yosidaCLM_ge
import Mathlib
import Definitions.Def_ChapterNonnegSemigroupGenerator
import Theorems.Thm_BookProof_NonnegResolvent_yosidaCLM_apply
import Theorems.Thm_BookProof_NonnegResolvent_yosidaCLM_mem
open BookProof.NonnegSemigroupGenerator




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open BookProof.NonnegResolvent BookProof.NonnegUnitaryGroup BookProof.NonnegSemigroup
open Filter Topology NormedSpace

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) {a lam : ℝ} (ha : 0 < a) (hlam : 0 ≤ lam)
    (hgap : ∀ h k : F, (h, k) ∈ T → lam * ‖h‖ ^ 2 ≤ (inner ℂ h k : ℂ).re) (h : F) :
    (a * lam / (a + lam)) * ‖h‖ ^ 2 ≤ (inner ℂ (yosidaCLM hT ha h) h : ℂ).re := by

  set y : F := (a : ℂ) • invCLMAt hT ha h with hy
  set z : F := yosidaCLM hT ha h with hz
  have hmem : (y, z) ∈ T := yosidaCLM_mem hT ha h
  have hsum : (a : ℂ) • h = (a : ℂ) • y + z := by
    rw [hy, hz, yosidaCLM_apply, smul_smul, smul_sub, smul_smul]
    module
  set v : ℝ := (inner ℂ y z : ℂ).re with hv
  have hvz : (inner ℂ z y : ℂ).re = v := by
    rw [hv, ← inner_conj_symm z y, Complex.conj_re]
  have hgapy : lam * ‖y‖ ^ 2 ≤ v := hgap y z hmem
  have hcs : v ≤ ‖y‖ * ‖z‖ := by
    rw [hv]
    exact re_inner_le_norm (𝕜 := ℂ) y z
  have hzy : lam * ‖y‖ ≤ ‖z‖ := by
    rcases eq_or_lt_of_le (norm_nonneg y) with h0 | h0
    · rw [← h0]
      simp
    · have := hgapy.trans hcs
      have hy2 : lam * ‖y‖ * ‖y‖ ≤ ‖y‖ * ‖z‖ := by nlinarith
      nlinarith
  -- the two Pythagoras identities
  have hnorma : ‖((a : ℝ) : ℂ)‖ = a := by simp [abs_of_pos ha]
  have hE1 : a ^ 2 * ‖h‖ ^ 2 = a ^ 2 * ‖y‖ ^ 2 + 2 * a * v + ‖z‖ ^ 2 := by
    have hn : ‖(a : ℂ) • h‖ ^ 2 = ‖(a : ℂ) • y + z‖ ^ 2 := by rw [hsum]
    have hl : ‖(a : ℂ) • h‖ ^ 2 = a ^ 2 * ‖h‖ ^ 2 := by
      rw [norm_smul, hnorma, mul_pow]
    have hay : ‖(a : ℂ) • y‖ ^ 2 = a ^ 2 * ‖y‖ ^ 2 := by
      rw [norm_smul, hnorma, mul_pow]
    have hinner : (inner ℂ ((a : ℂ) • y) z : ℂ).re = a * v := by
      rw [inner_smul_left, Complex.conj_ofReal, Complex.mul_re]
      simp [hv]
    rw [hl, norm_add_sq (𝕜 := ℂ), hay] at hn
    simp only [RCLike.re_to_complex] at hn
    rw [hinner] at hn
    linarith
  have hE2 : a * (inner ℂ z h : ℂ).re = a * v + ‖z‖ ^ 2 := by
    have hstep : (inner ℂ z ((a : ℂ) • h) : ℂ) = inner ℂ z ((a : ℂ) • y + z) := by rw [hsum]
    rw [inner_add_right, inner_smul_right, inner_smul_right] at hstep
    have := congrArg Complex.re hstep
    simp only [Complex.mul_re, Complex.ofReal_re, Complex.ofReal_im, zero_mul, sub_zero,
      Complex.add_re] at this
    rw [hvz] at this
    have hzz : (inner ℂ z z : ℂ).re = ‖z‖ ^ 2 := inner_self_eq_norm_sq (𝕜 := ℂ) z
    rw [this, hzz]
  -- the algebraic core
  have hN : 0 ≤ v * (a - lam) + ‖z‖ ^ 2 - lam * a * ‖y‖ ^ 2 := by
    rcases le_total lam a with hc | hc
    · nlinarith [hgapy, hzy, norm_nonneg y, norm_nonneg z]
    · have hfac : 0 ≤ (‖z‖ - lam * ‖y‖) * (‖z‖ + a * ‖y‖) := by
        have h1 : 0 ≤ ‖z‖ - lam * ‖y‖ := by linarith
        have h2 : 0 ≤ ‖z‖ + a * ‖y‖ := by positivity
        exact mul_nonneg h1 h2
      nlinarith [hcs, hfac, norm_nonneg y, norm_nonneg z]
  have hid : a ^ 2 * ((inner ℂ z h : ℂ).re * (a + lam) - a * lam * ‖h‖ ^ 2)
      = a ^ 2 * (v * (a - lam) + ‖z‖ ^ 2 - lam * a * ‖y‖ ^ 2) := by
    linear_combination (a * (a + lam)) * hE2 - (a * lam) * hE1
  have hcancel : (inner ℂ z h : ℂ).re * (a + lam) - a * lam * ‖h‖ ^ 2
      = v * (a - lam) + ‖z‖ ^ 2 - lam * a * ‖y‖ ^ 2 :=
    mul_left_cancel₀ (pow_ne_zero 2 ha.ne') hid
  have hsum' : 0 < a + lam := by linarith
  rw [div_mul_eq_mul_div, div_le_iff₀ hsum']
  linarith [hN, hcancel]
