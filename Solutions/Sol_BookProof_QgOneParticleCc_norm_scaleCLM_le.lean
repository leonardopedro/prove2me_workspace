-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.norm_scaleCLM_le
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterHermiteQuadraticEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterHermiteProductCore
open BookProof.QgOneParticleCc




open MeasureTheory SchwartzMap Complex MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.HermiteQuadraticEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa
open BookProof.HermiteProductCore

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {R : ℝ} (hR : 0 < R) : ‖scaleCLM d R‖ ≤ R⁻¹ := by

  refine (norm_smul_le (R⁻¹) (ContinuousLinearMap.id ℝ (Vd d))).trans ?_
  have h1 : ‖ContinuousLinearMap.id ℝ (Vd d)‖ ≤ 1 := ContinuousLinearMap.norm_id_le
  have h2 : ‖(R⁻¹ : ℝ)‖ = R⁻¹ := by
    rw [Real.norm_eq_abs, abs_of_pos (by positivity)]
  rw [h2]
  nlinarith [norm_nonneg (ContinuousLinearMap.id ℝ (Vd d)), inv_pos.mpr hR]
