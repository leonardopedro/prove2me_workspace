-- Generated from ChapterWallEsaSemibounded.lean — solution of BookProof.WallEsaSemibounded.integral_conj_neg_deriv2_mul
import Mathlib
import Definitions.Def_ChapterWallEsaSemibounded
import Theorems.Thm_BookProof_SchrodingerCutoff_integral_deriv_eq_zero_of_hasCompactSupport
open BookProof.WallEsaSemibounded




open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa BookProof.WallEsaBddBelow

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (f : ℝ → ℂ)
    (h1 : ∀ x, HasDerivAt f (deriv f x) x)
    (h2 : ∀ x, Ha :=
  sDerivAt (deriv f) (deriv (deriv f) x) x) (x : ℝ) :
      HasDerivAt (fun t : ℝ => (starRingEnd ℂ) (deriv f t) * f t)
        ((starRingEnd ℂ) (deriv (deriv f) x) * f x + ((‖deriv f x‖ ^ 2 : ℝ) : ℂ)) x := by
    have hstar : HasDerivAt (fun y : ℝ => (starRingEnd ℂ) (deriv f y))
        ((starRingEnd ℂ) (deriv (deriv f) x)) x := (h2 x).star
    have hmul := hstar.mul (h1 x)
    have hsq : (starRingEnd ℂ) (deriv f x) * deriv f x = ((‖deriv f x‖ ^ 2 : ℝ) : ℂ) := by
      rw [Complex.normSq_eq_conj_mul_self.symm, Complex.sq_norm]
    rwa [hsq] at hmul
  
  /-- **Integration by parts once.**  For a compactly supported `C²` function on the line,
  `∫ conj(−f'') f = ∫ |f'|²`.  Both sides are real; the statement is phrased in `ℂ` so it
  can be substituted directly into an `L²` pairing. -/
  theorem integral_conj_neg_deriv2_mul (f : ℝ → ℂ)
      (hf : ContDiff ℝ 2 f) (hs : HasCompactSupport f) :
      ∫ x, (starRingEnd ℂ) (-deriv (deriv f) x) * f x = ((∫ x, ‖deriv f x‖ ^ 2 : ℝ) : ℂ) := by
    have hfd : Differentiable ℝ f := hf.differentiable (by norm_num)
    have hf1 : ContDiff ℝ 1 (deriv f) := hf.deriv'
    have hf1d : Differentiable ℝ (deriv f) := hf1.differentiable one_ne_zero
    have h1 : ∀ x, HasDerivAt f (deriv f x) x := fun x => (hfd x).hasDerivAt
    have h2 : ∀ x, HasDerivAt (deriv f) (deriv (deriv f) x) x := fun x => (hf1d x).hasDerivAt
    have hcont0 : Continuous f := hfd.continuous
    have hcont1 : Continuous (deriv f) := hf1d.continuous
    have hcont2 : Continuous (deriv (deriv f)) := hf1.continuous_deriv le_rfl
    have hs1 : HasCompactSupport (deriv f) := hs.deriv
    -- the energy density and its derivative
    set g : ℝ → ℂ := fun x => (starRingEnd ℂ) (deriv f x) * f x with hgdef
    set g' : ℝ → ℂ := fun x =>
      (starRingEnd ℂ) (deriv (deriv f) x) * f x + ((‖deriv f x‖ ^ 2 : ℝ) : ℂ) with hg'def
    have hgderiv : ∀ x, HasDerivAt g (g' x) x := by
      intro x
      have hx := hasDerivAt_conj_deriv_mul f h1 h2 x
      simpa [hgdef, hg'def] using hx
    have hg'cont : Continuous g' := by
      simp only [hg'def]
      fun_prop
    have hgsupp : HasCompactSupport g := hs.mul_left
    have hzero : ∫ x, g' x = 0 :=
      BookProof.SchrodingerCutoff.integral_deriv_eq_zero_of_hasCompactSupport hgderiv hg'cont hgsupp
    -- split the integral
    have hIa : Integrable fun x => (starRingEnd ℂ) (deriv (deriv f) x) * f x :=
      (by fun_prop : Continuous fun x => (starRingEnd ℂ) (deriv (deriv f) x) * f x
        ).integrable_of_hasCompactSupport hs.mul_left
    have hIb : Integrable fun x => ((‖deriv f x‖ ^ 2 : ℝ) : ℂ) :=
      (by fun_prop : Continuous fun x => ((‖deriv f x‖ ^ 2 : ℝ) : ℂ)
        ).integrable_of_hasCompactSupport (by
          exact hs1.
