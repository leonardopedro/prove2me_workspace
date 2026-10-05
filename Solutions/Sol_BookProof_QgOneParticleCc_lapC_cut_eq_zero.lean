-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.lapC_cut_eq_zero
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
import Theorems.Thm_BookProof_QgOneParticleCc_dcoord_cut_eq_zero
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
theorem solution {R : ℝ} {x : Vd d} (hx : ‖x‖ < R) :
    lapC (fun y : Vd d => ((cut d R y : ℝ) : ℂ)) x = 0 := by

  have hopen : IsOpen {y : Vd d | ‖y‖ < R} := isOpen_lt (by fun_prop) continuous_const
  refine Finset.sum_eq_zero fun j _ => ?_
  have hev : dcoord j (fun y : Vd d => ((cut d R y : ℝ) : ℂ)) =ᶠ[nhds x] fun _ => (0 : ℂ) := by
    filter_upwards [hopen.mem_nhds hx] with y hy
    exact dcoord_cut_eq_zero hy j
  simp only [dcoord]
  rw [hev.fderiv_eq]
  simp
