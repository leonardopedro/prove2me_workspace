-- Generated from ChapterDisplacedThermalMulti.lean — solution of BookProof.ChapterDisplacedThermalMulti.dtOverlapMulti_eq_integral
import Mathlib
import Definitions.Def_ChapterDisplacedThermalMulti
open BookProof.ChapterDisplacedThermalMulti



noncomputable section

open MeasureTheory ProbabilityTheory Real
open scoped NNReal


open BookProof.ChapterDisplacedThermalOverlap

variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (nbar : ℝ≥0) (a b : EuclideanSpace ℝ (Fin n)) :
    dtOverlapMulti nbar a b
      = ∫ x : Fin n → ℝ, ∏ i, (gaussianPDFReal (a i) (tauNN nbar) (x i)
          * gaussianPDFReal (b i) (tauNN nbar) (x i)) := by

  rw [dtOverlapMulti,
    MeasureTheory.integral_fintype_prod_volume_eq_prod
      (fun i (y : ℝ) => gaussianPDFReal (a i) (tauNN nbar) y
        * gaussianPDFReal (b i) (tauNN nbar) y)]
  rfl
