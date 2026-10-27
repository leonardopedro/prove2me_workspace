-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.fderiv_cut
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
import Theorems.Thm_BookProof_QgOneParticleCc_cut_eq_comp
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
    fderiv ℝ (cut d R) x = (fderiv ℝ (bump d) (scaleCLM d R x)).comp (scaleCLM d R) := by

  have h1 : HasFDerivAt (bump d) (fderiv ℝ (bump d) (scaleCLM d R x)) (scaleCLM d R x) :=
    (((bump_spec d).1.differentiable (by simp)) _).hasFDerivAt
  have h2 : HasFDerivAt (fun y : Vd d => scaleCLM d R y) (scaleCLM d R) x :=
    (scaleCLM d R).hasFDerivAt
  have h := h1.comp x h2
  rw [cut_eq_comp]
  exact h.fderiv
