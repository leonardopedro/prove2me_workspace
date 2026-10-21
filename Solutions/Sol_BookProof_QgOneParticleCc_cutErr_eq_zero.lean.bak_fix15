-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.cutErr_eq_zero
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
import Theorems.Thm_BookProof_QgOneParticleCc_cut_eq_one
import Theorems.Thm_BookProof_QgOneParticleCc_dcoord_cut_eq_zero
import Theorems.Thm_BookProof_QgOneParticleCc_lapC_cut_eq_zero
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
theorem solution (W : Vd d → ℝ) {R : ℝ} (p : MvPolynomial (Fin d) ℂ) {z : Vd d}
    (hz : ‖z‖ < R) : cutErr W R p z = 0 := by

  have h1 : ((cut d R z : ℝ) : ℂ) = 1 := by
    rw [cut_eq_one (lt_of_le_of_lt (norm_nonneg z) hz) (le_of_lt hz)]
    norm_num
  have h2 : lapC (fun y : Vd d => ((cut d R y : ℝ) : ℂ)) z = 0 := lapC_cut_eq_zero hz
  have h3 : ∑ j : Fin d,
      dcoord j (fun y : Vd d => ((cut d R y : ℝ) : ℂ)) z * pgFun (coreD j p) z = 0 :=
    Finset.sum_eq_zero fun j _ => by rw [dcoord_cut_eq_zero hz j, zero_mul]
  simp only [cutErr, h1, h2, h3]
  ring
