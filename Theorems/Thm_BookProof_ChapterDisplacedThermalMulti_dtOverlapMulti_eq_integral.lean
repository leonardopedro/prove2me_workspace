-- Generated from ChapterDisplacedThermalMulti.lean — theorem BookProof.ChapterDisplacedThermalMulti.dtOverlapMulti_eq_integral
import Mathlib
import Definitions.Def_ChapterDisplacedThermalMulti
import Definitions.Def_ChapterDisplacedThermalOverlap
open BookProof.ChapterDisplacedThermalOverlap
open BookProof.ChapterDisplacedThermalMulti

variable {n m : ℕ}


noncomputable section

open MeasureTheory ProbabilityTheory Real
open scoped NNReal


open BookProof.ChapterDisplacedThermalOverlap


theorem BookProof.ChapterDisplacedThermalMulti.dtOverlapMulti_eq_integral (nbar : ℝ≥0) (a b : EuclideanSpace ℝ (Fin n)) :
    dtOverlapMulti nbar a b
      = ∫ x : Fin n → ℝ, ∏ i, (gaussianPDFReal (a i) (tauNN nbar) (x i)
          * gaussianPDFReal (b i) (tauNN nbar) (x i)) := by sorry
