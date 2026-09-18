import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterWeakSecondDerivative
-- Generated from ChapterScalaronWallEsa.lean — solution of BookProof.ScalaronWallEsa.ode_solution_eq_zero
import Mathlib
import Definitions.Def_ChapterScalaronWallEsa
import Theorems.Thm_BookProof_ScalaronWallEsa_eq_zero_of_convexOn_nonneg_integrable
open BookProof.ScalaronWallEsa













open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.Starobinsky BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent
open BookProof.WeakSecondDeriv

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {V : ℝ → ℝ} (hVnn : ∀ x, 0 ≤ V x) {z : ℂ} (hz : z.re = 0)
    {W W' : ℝ → ℂ} (hW : ∀ x, HasDerivAt W (W' x) x)
    (hW' : ∀ x, HasDerivAt W' ((((V x : ℝ) : ℂ) - z) * W x) x)
    (hint : Integrable (fun x => ‖W x‖ ^ 2) volume) :
    ∀ x, W x = 0 := by

  have hdp : ∀ x, HasDerivAt (fun y => (W y).re) ((W' x).re) x := fun x =>
    Complex.reCLM.hasFDerivAt.comp_hasDerivAt x (hW x)
  have hdq : ∀ x, HasDerivAt (fun y => (W y).im) ((W' x).im) x := fun x =>
    Complex.imCLM.hasFDerivAt.comp_hasDerivAt x (hW x)
  have hdp' : ∀ x, HasDerivAt (fun y => (W' y).re) (((((V x : ℝ) : ℂ) - z) * W x).re) x := fun x =>
    Complex.reCLM.hasFDerivAt.comp_hasDerivAt x (hW' x)
  have hdq' : ∀ x, HasDerivAt (fun y => (W' y).im) (((((V x : ℝ) : ℂ) - z) * W x).im) x := fun x =>
    Complex.imCLM.hasFDerivAt.comp_hasDerivAt x (hW' x)
  have hdF : ∀ x, HasDerivAt (fun y => (W y).re ^ 2 + (W y).im ^ 2)
      (2 * (W x).re * (W' x).re + 2 * (W x).im * (W' x).im) x := by
    intro x
    have h1 : HasDerivAt (fun y => (W y).re ^ 2) (2 * (W x).re * (W' x).re) x := by
      simpa [mul_comm, mul_assoc, mul_left_comm] using (hdp x).pow 2
    have h2 : HasDerivAt (fun y => (W y).im ^ 2) (2 * (W x).im * (W' x).im) x := by
      simpa [mul_comm, mul_assoc, mul_left_comm] using (hdq x).pow 2
    exact h1.add h2
  have hdG : ∀ x, HasDerivAt (fun y => 2 * (W y).re * (W' y).re + 2 * (W y).im * (W' y).im)
      (2 * ((W' x).re ^ 2 + (W' x).im ^ 2) + 2 * V x * ((W x).re ^ 2 + (W x).im ^ 2)) x := by
    intro x
    have hsum := (((hdp x).const_mul (2:ℝ)).mul (hdp' x)).add
      (((hdq x).const_mul (2:ℝ)).mul (hdq' x))
    have hval : 2 * (W' x).re * (W' x).re + 2 * (W x).re * ((((V x : ℝ) : ℂ) - z) * W x).re
        + (2 * (W' x).im * (W' x).im + 2 * (W x).im * ((((V x : ℝ) : ℂ) - z) * W x).im)
        = 2 * ((W' x).re ^ 2 + (W' x).im ^ 2) + 2 * V x * ((W x).re ^ 2 + (W x).im ^ 2) := by
      simp only [Complex.sub_re, Complex.sub_im, Complex.mul_re, Complex.mul_im,
        Complex.ofReal_re, Complex.ofReal_im, hz]
      ring
    rw [← hval]
    exact hsum
  have hFconv : ConvexOn ℝ univ (fun y => (W y).re ^ 2 + (W y).im ^ 2) := by
    have h1 : deriv (fun y => (W y).re ^ 2 + (W y).im ^ 2)
        = fun y => 2 * (W y).re * (W' y).re + 2 * (W y).im * (W' y).im :=
      funext fun x => (hdF x).deriv
    refine convexOn_univ_of_deriv2_nonneg (fun x => (hdF x).differentiableAt) ?_ ?_
    · rw [h1]; exact fun x => (hdG x).differentiableAt
    · intro x
      have h2 : deriv^[2] (fun y => (W y).re ^ 2 + (W y).im ^ 2)
          = deriv fun y => 2 * (W y).re * (W' y).re + 2 * (W y).im * (W' y).im := by
        simp [Function.iterate_succ, h1]
      rw [h2, (hdG x).deriv]
      have := hVnn x
      positivity
  have hFnn : ∀ x, 0 ≤ (W x).re ^ 2 + (W x).im ^ 2 := fun x => by positivity
  have hFint : Integrable (fun y => (W y).re ^ 2 + (W y).im ^ 2) volume := by
    refine hint.congr (Filter.Eventually.of_forall fun x => ?_)
    change ‖W x‖ ^ 2 = (W x).re ^ 2 + (W x).im ^ 2
    rw [← Complex.normSq_eq_norm_sq, Complex.normSq_apply]; ring
  intro x
  have hzero := eq_zero_of_convexOn_nonneg_integrable hFconv hFnn hFint x
  have hn : Complex.normSq (W x) = 0 := by
    rw [Complex.normSq_apply]; nlinarith [hzero]
  exact Complex.normSq_eq_zero.1 hn
