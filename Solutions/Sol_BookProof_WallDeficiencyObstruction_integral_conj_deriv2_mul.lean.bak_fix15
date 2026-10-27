-- Generated from ChapterWallDeficiencyObstruction.lean — solution of BookProof.WallDeficiencyObstruction.integral_conj_deriv2_mul
import Mathlib
import Definitions.Def_ChapterWallDeficiencyObstruction
open BookProof.WallDeficiencyObstruction




open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa
open BookProof.WeakSecondDeriv

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {P P' P'' : ℝ → ℂ} {W W' G : ℝ → ℂ}
    (hP : ∀ x, HasDerivAt P (P' x) x) (hP' : ∀ x, HasDerivAt P' (P'' x) x)
    (hP''c : Continuous P'') (hPsupp : HasCompactSupport P)
    (hW : ∀ x, HasDerivAt W (W' x) x) (hW' : ∀ x, HasDerivAt W' (G x) x)
    (hGc : Continuous G) :
    ∫ x, (starRingEnd ℂ) (P'' x) * W x = ∫ x, (starRingEnd ℂ) (P x) * G x := by

  have hPeq : P' = deriv P := funext fun x => (hP x).deriv.symm
  have hP'eq : P'' = deriv P' := funext fun x => (hP' x).deriv.symm
  have hP'supp : HasCompactSupport P' := by rw [hPeq]; exact hPsupp.deriv
  have hP''supp : HasCompactSupport P'' := by rw [hP'eq]; exact hP'supp.deriv
  have hPcont : Continuous P := continuous_iff_continuousAt.2 fun x => (hP x).continuousAt
  have hP'cont : Continuous P' := continuous_iff_continuousAt.2 fun x => (hP' x).continuousAt
  have hWcont : Continuous W := continuous_iff_continuousAt.2 fun x => (hW x).continuousAt
  have hW'cont : Continuous W' := continuous_iff_continuousAt.2 fun x => (hW' x).continuousAt
  set f : ℝ → ℂ := fun x => (starRingEnd ℂ) (P x) * W' x - (starRingEnd ℂ) (P' x) * W x with hf
  have hfd : ∀ x, HasDerivAt f
      ((starRingEnd ℂ) (P x) * G x - (starRingEnd ℂ) (P'' x) * W x) x := by
    intro x
    have h1 : HasDerivAt (fun y : ℝ => (starRingEnd ℂ) (P y) * W' y)
        ((starRingEnd ℂ) (P' x) * W' x + (starRingEnd ℂ) (P x) * G x) x :=
      (hP x).star.mul (hW' x)
    have h2 : HasDerivAt (fun y : ℝ => (starRingEnd ℂ) (P' y) * W y)
        ((starRingEnd ℂ) (P'' x) * W x + (starRingEnd ℂ) (P' x) * W' x) x :=
      (hP' x).star.mul (hW x)
    have h3 := h1.sub h2
    have heq : ((starRingEnd ℂ) (P' x) * W' x + (starRingEnd ℂ) (P x) * G x)
          - ((starRingEnd ℂ) (P'' x) * W x + (starRingEnd ℂ) (P' x) * W' x)
        = (starRingEnd ℂ) (P x) * G x - (starRingEnd ℂ) (P'' x) * W x := by
      ring
    rw [heq] at h3
    exact h3
  have hAsupp : HasCompactSupport (fun x => (starRingEnd ℂ) (P x) * G x) :=
    (hPsupp.comp_left (g := fun z : ℂ => (starRingEnd ℂ) z) (by simp)).mul_right
  have hBsupp : HasCompactSupport (fun x => (starRingEnd ℂ) (P'' x) * W x) :=
    (hP''supp.comp_left (g := fun z : ℂ => (starRingEnd ℂ) z) (by simp)).mul_right
  have hAint : Integrable (fun x => (starRingEnd ℂ) (P x) * G x) volume :=
    ((Complex.continuous_conj.comp hPcont).mul hGc).integrable_of_hasCompactSupport hAsupp
  have hBint : Integrable (fun x => (starRingEnd ℂ) (P'' x) * W x) volume :=
    ((Complex.continuous_conj.comp hP''c).mul hWcont).integrable_of_hasCompactSupport hBsupp
  have hfsupp : HasCompactSupport f :=
    HasCompactSupport.sub
      ((hPsupp.comp_left (g := fun z : ℂ => (starRingEnd ℂ) z) (by simp)).mul_right)
      ((hP'supp.comp_left (g := fun z : ℂ => (starRingEnd ℂ) z) (by simp)).mul_right)
  have hfcont : Continuous f :=
    ((Complex.continuous_conj.comp hPcont).mul hW'cont).sub
      ((Complex.continuous_conj.comp hP'cont).mul hWcont)
  have hzero := MeasureTheory.integral_eq_zero_of_hasDerivAt_of_integrable hfd
    (hAint.sub hBint) (hfcont.integrable_of_hasCompactSupport hfsupp)
  rw [integral_sub hAint hBint] at hzero
  exact (sub_eq_zero.mp hzero).symm
