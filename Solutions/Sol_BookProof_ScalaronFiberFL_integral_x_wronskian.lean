-- Generated from ChapterScalaronFiberFL.lean — solution of BookProof.ScalaronFiberFL.integral_x_wronskian
import Mathlib
import Definitions.Def_ChapterScalaronFiberFL
open BookProof.ScalaronFiberFL




open MeasureTheory SchwartzMap
open BookProof.StrichartzWave
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallEsaSemibounded BookProof.WallEsaBddBelow
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.SchrodingerCutoff BookProof.FriedrichsExtension

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (f g : ℝ → ℂ)
    (hf : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) f) (hg : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) g)
    (hfs : HasCompactSupport f) (hgs : HasCompactSupport g) :
    (∫ x : ℝ, (x : ℂ) * ((starRingEnd ℂ) (f x) * deriv (deriv g) x
        - (starRingEnd ℂ) (deriv (deriv f) x) * g x))
      = -2 * ∫ x : ℝ, (starRingEnd ℂ) (f x) * deriv g x := by

  have hf1 : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (deriv f) := hf.deriv'
  have hf2 : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (deriv (deriv f)) := hf1.deriv'
  have hg1 : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (deriv g) := hg.deriv'
  have hg2 : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (deriv (deriv g)) := hg1.deriv'
  have hd0 : ∀ x, HasDerivAt f (deriv f x) x := fun x =>
    (hf.differentiable (by simp) x).hasDerivAt
  have hd1 : ∀ x, HasDerivAt (deriv f) (deriv (deriv f) x) x := fun x =>
    (hf1.differentiable (by simp) x).hasDerivAt
  have he0 : ∀ x, HasDerivAt g (deriv g x) x := fun x =>
    (hg.differentiable (by simp) x).hasDerivAt
  have he1 : ∀ x, HasDerivAt (deriv g) (deriv (deriv g) x) x := fun x =>
    (hg1.differentiable (by simp) x).hasDerivAt
  -- the conjugated derivatives
  have ha0 : ∀ x, HasDerivAt (fun y => (starRingEnd ℂ) (f y))
      ((starRingEnd ℂ) (deriv f x)) x := fun x => (hd0 x).star
  have ha1 : ∀ x, HasDerivAt (fun y => (starRingEnd ℂ) (deriv f y))
      ((starRingEnd ℂ) (deriv (deriv f) x)) x := fun x => (hd1 x).star
  have hcf : Continuous f := hf.continuous
  have hcf1 : Continuous (deriv f) := hf1.continuous
  have hcf2 : Continuous (deriv (deriv f)) := hf2.continuous
  have hcg : Continuous g := hg.continuous
  have hcg1 : Continuous (deriv g) := hg1.continuous
  have hcg2 : Continuous (deriv (deriv g)) := hg2.continuous
  have hfs1 : HasCompactSupport (deriv f) := hfs.deriv
  have hfs2 : HasCompactSupport (deriv (deriv f)) := hfs1.deriv
  have hgs1 : HasCompactSupport (deriv g) := hgs.deriv
  have hgs2 : HasCompactSupport (deriv (deriv g)) := hgs1.deriv
  have hcs0 : HasCompactSupport fun y => (starRingEnd ℂ) (f y) :=
    hfs.comp_left (g := starRingEnd ℂ) (by simp)
  have hcs1 : HasCompactSupport fun y => (starRingEnd ℂ) (deriv f y) :=
    hfs1.comp_left (g := starRingEnd ℂ) (by simp)
  have hcs2 : HasCompactSupport fun y => (starRingEnd ℂ) (deriv (deriv f) y) :=
    hfs2.comp_left (g := starRingEnd ℂ) (by simp)
  -- Step 1: `∫ (conj f' · g + conj f · g') = 0`
  have step2 : (∫ x, ((starRingEnd ℂ) (deriv f x) * g x
      + (starRingEnd ℂ) (f x) * deriv g x)) = 0 := by
    refine integral_deriv_eq_zero_of_hasCompactSupport
      (g := fun x => (starRingEnd ℂ) (f x) * g x) (fun x => ?_) (by fun_prop) hcs0.mul_right
    exact (ha0 x).mul (he0 x)
  -- Step 2: `∫ d/dx [x (conj f · g' − conj f' · g)] = 0`
  have step1 : (∫ x : ℝ, (((starRingEnd ℂ) (f x) * deriv g x
        - (starRingEnd ℂ) (deriv f x) * g x)
      + (x : ℂ) * ((starRingEnd ℂ) (f x) * deriv (deriv g) x
        - (starRingEnd ℂ) (deriv (deriv f) x) * g x))) = 0 := by
    refine integral_deriv_eq_zero_of_hasCompactSupport
      (g := fun x => (x : ℂ) * ((starRingEnd ℂ) (f x) * deriv g x
        - (starRingEnd ℂ) (deriv f x) * g x)) (fun x => ?_) (by fun_prop)
      ((hcs0.mul_right.sub hcs1.mul_right).mul_left)
    have hx : HasDerivAt (fun y : ℝ => (y : ℂ)) 1 x := by
      simpa using (Complex.ofRealCLM.hasDerivAt (x := x))
    have hprod : HasDerivAt (fun y => (starRingEnd ℂ) (f y) * deriv g y
        - (starRingEnd ℂ) (deriv f y) * g y)
        (((starRingEnd ℂ) (deriv f x) * deriv g x
            + (starRingEnd ℂ) (f x) * deriv (deriv g) x)
          - ((starRingEnd ℂ) (deriv (deriv f) x) * g x
            + (starRingEnd ℂ) (deriv f x) * deriv g x)) x :=
      ((ha0 x).mul (he1 x)).sub ((ha1 x).mul (he0 x))
    have := hx.mul hprod
    convert this using 1
    ring
  -- integrability of the pieces
  have hI1 : Integrable fun x => (starRingEnd ℂ) (f x) * deriv g x :=
    (by fun_prop : Continuous fun x => (starRingEnd ℂ) (f x) * deriv g x
      ).integrable_of_hasCompactSupport hcs0.mul_right
  have hI2 : Integrable fun x => (starRingEnd ℂ) (deriv f x) * g x :=
    (by fun_prop : Continuous fun x => (starRingEnd ℂ) (deriv f x) * g x
      ).integrable_of_hasCompactSupport hcs1.mul_right
  have hI3 : Integrable fun x : ℝ => (x : ℂ) * ((starRingEnd ℂ) (f x) * deriv (deriv g) x
      - (starRingEnd ℂ) (deriv (deriv f) x) * g x) :=
    (by fun_prop : Continuous fun x : ℝ => (x : ℂ) * ((starRingEnd ℂ) (f x) * deriv (deriv g) x
        - (starRingEnd ℂ) (deriv (deriv f) x) * g x)
      ).integrable_of_hasCompactSupport ((hcs0.mul_right.sub hcs2.mul_right).mul_left)
  have hI4 : Integrable fun x : ℝ => (starRingEnd ℂ) (f x) * deriv g x
      - (starRingEnd ℂ) (deriv f x) * g x := hI1.sub hI2
  rw [integral_add hI4 hI3, integral_sub hI1 hI2] at step1
  rw [integral_add hI2 hI1] at step2
  linear_combination step1 + step2
