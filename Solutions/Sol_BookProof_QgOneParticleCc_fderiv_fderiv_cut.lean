-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.fderiv_fderiv_cut
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
import Theorems.Thm_BookProof_QgOneParticleCc_fderiv_cut
open BookProof.QgOneParticleCc




open MeasureTheory SchwartzMap Complex MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.HermiteQuadraticEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (R : ℝ) (x : Vd d) :
    fderiv ℝ (fun y : Vd d => fderiv ℝ (cut d R) y) x
      = (((ContinuousLinearMap.compL ℝ (Vd d) (Vd d) ℝ).flip (scaleCLM d R)).comp
          ((fderiv ℝ (fun y : Vd d => fderiv ℝ (bump d) y) (scaleCLM d R x)).comp
            (scaleCLM d R))) := by

  have hfun : (fun y : Vd d => fderiv ℝ (cut d R) y)
      = fun y : Vd d =>
          ((ContinuousLinearMap.compL ℝ (Vd d) (Vd d) ℝ).flip (scaleCLM d R))
            (fderiv ℝ (bump d) (scaleCLM d R y)) := by
    funext y
    rw [fderiv_cut]
    rfl
  rw [hfun]
  have hbd : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (fun y : Vd d => fderiv ℝ (bump d) y) :=
    (bump_spec d).1.fderiv_right (m := ((⊤ : ℕ∞) : WithTop ℕ∞)) le_rfl
  have h1 : HasFDerivAt (fun y : Vd d => fderiv ℝ (bump d) y)
      (fderiv ℝ (fun y : Vd d => fderiv ℝ (bump d) y) (scaleCLM d R x)) (scaleCLM d R x) :=
    ((hbd.differentiable (by simp)) _).hasFDerivAt
  have h2 : HasFDerivAt (fun y : Vd d => scaleCLM d R y) (scaleCLM d R) x :=
    (scaleCLM d R).hasFDerivAt
  have h3 := h1.comp x h2
  have h4 := (((ContinuousLinearMap.compL ℝ (Vd d) (Vd d) ℝ).flip
    (scaleCLM d R)).hasFDerivAt).comp x h3
  exact h4.fderiv
