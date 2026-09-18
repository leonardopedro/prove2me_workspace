-- Generated from ChapterScalaronFiberFL.lean — solution of BookProof.ScalaronFiberFL.ham_x_comm
import Mathlib
import Definitions.Def_ChapterScalaronFiberFL
import Theorems.Thm_BookProof_ScalaronFiberFL_integral_x_wronskian
import Theorems.Thm_BookProof_ScalaronFiberFL_inner_xCc_ham
import Theorems.Thm_BookProof_ScalaronFiberFL_inner_derivL2
open BookProof.ScalaronFiberFL




open MeasureTheory SchwartzMap
open BookProof.StrichartzWave
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.SchrodingerCutoff BookProof.FriedrichsExtension

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (W : WallPot) (s : ℝ) (f g : ccSchwartz ℝ) :
    (starRingEnd ℂ) (inner ℂ (xCc (ccEquiv ℝ g)) (W.ham s (ccEquiv ℝ f)) : ℂ)
      - (inner ℂ (xCc (ccEquiv ℝ f)) (W.ham s (ccEquiv ℝ g)) : ℂ)
      = -2 * (inner ℂ ((ccEquiv ℝ f : ccDomain ℝ) : L2R) (derivL2 g) : ℂ) := by

  set F : ℝ → ℂ := ((f : 𝓢(ℝ, ℂ)) : ℝ → ℂ) with hFdef
  set G : ℝ → ℂ := ((g : 𝓢(ℝ, ℂ)) : ℝ → ℂ) with hGdef
  have hFs : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) F := (f : 𝓢(ℝ, ℂ)).smooth _
  have hGs : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) G := (g : 𝓢(ℝ, ℂ)).smooth _
  have hFc : Continuous F := hFs.continuous
  have hGc : Continuous G := hGs.continuous
  have hF1s : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (deriv F) := hFs.deriv'
  have hF2s : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (deriv (deriv F)) := hF1s.deriv'
  have hG1s : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (deriv G) := hGs.deriv'
  have hG2s : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (deriv (deriv G)) := hG1s.deriv'
  have hF2 : Continuous (deriv (deriv F)) := hF2s.continuous
  have hG2 : Continuous (deriv (deriv G)) := hG2s.continuous
  have hpotc : Continuous (W.pot s) := (W.pot_smooth s).continuous
  have hsF : HasCompactSupport F := f.2
  have hsG : HasCompactSupport G := g.2
  -- the two pairings, as integrals
  have e1 := inner_xCc_ham W s f g
  have e2 := inner_xCc_ham W s g f
  have e3 := inner_derivL2 f g
  have e1c : (starRingEnd ℂ) (inner ℂ (xCc (ccEquiv ℝ g)) (W.ham s (ccEquiv ℝ f)) : ℂ)
      = ∫ y : ℝ, (y : ℂ) * (G y * (-(starRingEnd ℂ) (deriv (deriv F) y)
          + (W.pot s y : ℂ) * (starRingEnd ℂ) (F y))) := by
    rw [e1, ← integral_conj]
    refine integral_congr_ae (Filter.Eventually.of_forall fun y => ?_)
    simp only [map_mul, map_add, map_neg, Complex.conj_ofReal, RingHomCompTriple.comp_apply,
      RingHom.id_apply]
    ring
  -- integrability
  have hIa : Integrable fun y : ℝ => (y : ℂ) * (G y * (-(starRingEnd ℂ) (deriv (deriv F) y)
      + (W.pot s y : ℂ) * (starRingEnd ℂ) (F y))) := by
    refine Continuous.integrable_of_hasCompactSupport ?_ (hsG.mul_right.mul_left)
    exact (Complex.continuous_ofReal.mul (hGc.mul (((Complex.continuous_conj.comp hF2)).neg.add
      ((Complex.continuous_ofReal.comp hpotc).mul (Complex.continuous_conj.comp hFc)))))
  have hIb : Integrable fun y : ℝ => (y : ℂ) * ((starRingEnd ℂ) (F y)
      * (-deriv (deriv G) y + (W.pot s y : ℂ) * G y)) := by
    refine Continuous.integrable_of_hasCompactSupport ?_
      (((hsF.comp_left (g := starRingEnd ℂ) (by simp)).mul_right).mul_left)
    exact (Complex.continuous_ofReal.mul ((Complex.continuous_conj.comp hFc).mul
      (hG2.neg.add ((Complex.continuous_ofReal.comp hpotc).mul hGc))))
  rw [e1c, e2, e3, ← integral_sub hIa hIb]
  rw [show (∫ y : ℝ, ((y : ℂ) * (G y * (-(starRingEnd ℂ) (deriv (deriv F) y)
        + (W.pot s y : ℂ) * (starRingEnd ℂ) (F y)))
      - (y : ℂ) * ((starRingEnd ℂ) (F y) * (-deriv (deriv G) y + (W.pot s y : ℂ) * G y))))
      = ∫ y : ℝ, (y : ℂ) * ((starRingEnd ℂ) (F y) * deriv (deriv G) y
        - (starRingEnd ℂ) (deriv (deriv F) y) * G y) from
    integral_congr_ae (Filter.Eventually.of_forall fun y => by ring)]
  exact integral_x_wronskian F G hFs hGs hsF hsG
