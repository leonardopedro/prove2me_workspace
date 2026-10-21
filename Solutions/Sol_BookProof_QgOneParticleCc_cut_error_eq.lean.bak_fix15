-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.cut_error_eq
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
import Theorems.Thm_BookProof_QgOneParticleCc_lapC_mul
import Theorems.Thm_BookProof_QgOneParticleCc_dcoord_pgFun
import Theorems.Thm_BookProof_QgOneParticleCc_lapC_pgFun
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
theorem solution (W : Vd d → ℝ) {R : ℝ} (p : MvPolynomial (Fin d) ℂ) (z : Vd d) :
    -lapC (cutFun R p) z + ((W z : ℝ) : ℂ) * cutFun R p z
        - (pgFun (kinPoly p) z + ((W z : ℝ) : ℂ) * pgFun p z)
      = cutErr W R p z := by

  have hcutC : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (fun y : Vd d => ((cut d R y : ℝ) : ℂ)) :=
    Complex.ofRealCLM.contDiff.comp (contDiff_cut R)
  have hlap := lapC_mul hcutC (contDiff_pgFun p) z
  have hpsi : lapC (pgFun p) z = -pgFun (kinPoly p) z := congrFun (lapC_pgFun p) z
  have hcutFun : cutFun R p = fun y : Vd d => ((cut d R y : ℝ) : ℂ) * pgFun p y := rfl
  rw [hcutFun, hlap, hpsi]
  simp only [dcoord_pgFun, cutErr]
  ring
