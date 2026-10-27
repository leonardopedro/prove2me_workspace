-- Generated from ChapterNavierStokesFockParcels.lean — solution of BookProof.NavierStokesFlow.FockLagrangian.fockMeasure_tailStep_pos
import Mathlib
import Definitions.Def_ChapterNavierStokesFockParcels
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockLagrangian



open MeasureTheory



open FullEsa FockContinuum

variable {Ω : Type*} [MeasurableSpace Ω]

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) : 0 < fockR (tailStep k) := by

  rw [tailStep, fockMeasure_sector (volume : Measure ℝ)
    (MeasurableSet.univ_pi fun _ => measurableSet_Icc), Measure.pi_pi]
  simp only [Fin.prod_univ_one, volume_tail_Icc]
  exact ENNReal.pow_pos (by norm_num) k
