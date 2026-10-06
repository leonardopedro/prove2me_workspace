-- Generated from ChapterOdeUnitaryFlow.lean — solution of BookProof.OdeUnitaryFlow.hasDerivAt_odeKoop_zero
import Mathlib
import Definitions.Def_ChapterOdeUnitaryFlow
open BookProof.OdeUnitaryFlow




open MeasureTheory Filter Set
open scoped Topology ENNReal

set_option maxHeartbeats 1000000 in
theorem solution (ψ : ℝ → ℂ) (x : ℝ) (d : ℂ) (hψ : HasDerivAt ψ d x) :
    HasDerivAt (fun t : ℝ => odeKoop t ψ x) (-((x : ℂ) ^ 2 * d + (x : ℂ) * ψ x)) 0 := by

  have hlin : HasDerivAt (fun t : ℝ => 1 + t * x) x 0 := by
    simpa using ((hasDerivAt_id (0 : ℝ)).mul_const x).const_add 1
  have h0 : (1 + (0 : ℝ) * x) ≠ 0 := by norm_num
  have hu : HasDerivAt (fun t : ℝ => (1 + t * x)⁻¹) (-x) 0 := by
    have h := hlin.inv h0
    simp at h
    exact h
  have hden : HasDerivAt (fun t : ℝ => ((1 + t * x : ℝ) : ℂ)⁻¹) (-(x : ℂ)) 0 := by
    have h := Complex.ofRealCLM.hasDerivAt.scomp (0 : ℝ) hu
    simpa [Function.comp_def, Complex.ofReal_inv] using h
  have hmobt : HasDerivAt (fun t : ℝ => mob t x) (-(x ^ 2)) 0 := by
    have h := hu.const_mul x
    have hfun : (fun t : ℝ => x * (1 + t * x)⁻¹) = fun t : ℝ => mob t x := by
      funext t; simp [mob, div_eq_mul_inv]
    rw [hfun] at h
    simpa [pow_two] using h
  have hψ0 : HasDerivAt ψ d (mob 0 x) := by simpa using hψ
  have hcomp : HasDerivAt (fun t : ℝ => ψ (mob t x)) ((-(x ^ 2) : ℝ) • d) 0 := by
    have h := hψ0.scomp (0 : ℝ) hmobt
    simpa [Function.comp_def] using h
  have hmul := hden.mul hcomp
  have hfun : (fun t : ℝ => odeKoop t ψ x)
      = fun t : ℝ => ((1 + t * x : ℝ) : ℂ)⁻¹ * ψ (mob t x) := rfl
  rw [hfun]
  convert hmul using 1
  · rfl
  · rfl
  · rw [mob_zero]
    norm_num [Complex.real_smul, Complex.ofReal_pow]
