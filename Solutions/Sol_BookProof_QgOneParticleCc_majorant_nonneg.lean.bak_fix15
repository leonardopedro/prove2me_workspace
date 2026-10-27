-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.majorant_nonneg
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
import Theorems.Thm_BookProof_QgOneParticleCc_sum_norm_coreD_nonneg
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
theorem solution (W : Vd d → ℝ) {K : ℝ} (hK : 0 ≤ K) (p : MvPolynomial (Fin d) ℂ)
    (z : Vd d) : 0 ≤ majorant W K p z :=
  add_nonneg (add_nonneg (add_nonneg (norm_nonneg _) (mul_nonneg hK (norm_nonneg _)))
      (mul_nonneg (by linarith) (sum_norm_coreD_nonneg p z))) (norm_nonneg _)
