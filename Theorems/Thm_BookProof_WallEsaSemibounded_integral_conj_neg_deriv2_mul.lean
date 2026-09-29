-- Generated from ChapterWallEsaSemibounded.lean — theorem BookProof.WallEsaSemibounded.integral_conj_neg_deriv2_mul
import Mathlib
import Definitions.Def_ChapterWallEsaSemibounded
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
open BookProof.WallEsaSemibounded










open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

theorem BookProof.WallEsaSemibounded.integral_conj_neg_deriv2_mul (f : ℝ → ℂ)
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
  set g : ℝ → ℂ := fun x => (starRingEnd ℂ) (deriv f x) * f x with hgdef
  set g' : ℝ → ℂ := fun x =>
    (starRingEnd ℂ) (deriv (deriv f) x) * f x + ((‖deriv f x‖ ^ 2 : ℝ) : ℂ) with hg'def
  have hgderiv : ∀ x, HasDerivAt g (g' x) x := by
    intro x
    have hstar : HasDerivAt (fun y => (starRingEnd ℂ) (deriv f y))
        ((starRingEnd ℂ) (deriv (deriv f) x)) x := (h2 x).star
    have hmul := hstar.mul (h1 x)
    have hsq : (starRingEnd ℂ) (deriv f x) * deriv f x = ((‖deriv f x‖ ^ 2 : ℝ) : ℂ) := by
      rw [Complex.normSq_eq_conj_mul_self.symm, Complex.sq_norm]
    simpa [hgdef, hg'def, hsq] using hmul
  have hg'cont : Continuous g' := by
    simp only [hg'def]
    fun_prop
  have hgsupp : HasCompactSupport g := hs.mul_left
  have hzero : ∫ x, g' x = 0 :=
    BookProof.SchrodingerCutoff.integral_deriv_eq_zero_of_hasCompactSupport hgderiv hg'cont hgsupp
  have hIa : Integrable fun x => (starRingEnd ℂ) (deriv (deriv f) x) * f x :=
    (by fun_prop : Continuous fun x => (starRingEnd ℂ) (deriv (deriv f) x) * f x
      ).integrable_of_hasCompactSupport hs.mul_left
  have hIb : Integrable fun x => ((‖deriv f x‖ ^ 2 : ℝ) : ℂ) :=
    (by fun_prop : Continuous fun x => ((‖deriv f x‖ ^ 2 : ℝ) : ℂ)
      ).integrable_of_hasCompactSupport (by
        exact hs1.comp_left (g := fun z : ℂ => ((‖z‖ ^ 2 : ℝ) : ℂ)) (by simp))
  have hsplit : (∫ x, g' x)
      = (∫ x, (starRingEnd ℂ) (deriv (deriv f) x) * f x)
        + ∫ x, ((‖deriv f x‖ ^ 2 : ℝ) : ℂ) := by
    simp only [hg'def]
    exact integral_add hIa hIb
  rw [hsplit] at hzero
  have hreal : (∫ x, ((‖deriv f x‖ ^ 2 : ℝ) : ℂ)) = ((∫ x, ‖deriv f x‖ ^ 2 : ℝ) : ℂ) :=
    integral_complex_ofReal
  rw [hreal] at hzero
  have hneg : (∫ x, (starRingEnd ℂ) (-deriv (deriv f) x) * f x)
      = -∫ x, (starRingEnd ℂ) (deriv (deriv f) x) * f x := by
    rw [← integral_neg]
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    simp
  rw [hneg]
  linear_combination -hzero
