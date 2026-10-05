-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.cut_eventuallyEq_one
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
import Theorems.Thm_BookProof_QgOneParticleCc_cut_eq_one
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
    (fun y : Vd d => ((cut d R y : ℝ) : ℂ)) =ᶠ[nhds x] fun _ => (1 : ℂ) := by

  have hRpos : 0 < R := lt_of_le_of_lt (norm_nonneg x) hx
  have hopen : IsOpen {y : Vd d | ‖y‖ < R} := isOpen_lt (by fun_prop) continuous_const
  filter_upwards [hopen.mem_nhds hx] with y hy
  rw [cut_eq_one hRpos (le_of_lt hy)]
  norm_num
