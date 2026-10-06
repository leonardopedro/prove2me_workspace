-- Generated from ChapterDisplacedThermalMulti.lean — theorem BookProof.ChapterDisplacedThermalMulti.dtOverlapMulti_eq
import Mathlib
import Definitions.Def_ChapterDisplacedThermalMulti
import Definitions.Def_ChapterDisplacedThermalOverlap
import Definitions.Def_ChapterHermiteProductCore
open BookProof.ChapterDisplacedThermalOverlap
open BookProof.HermiteProductCore
open BookProof.ChapterDisplacedThermalMulti

variable {n m : ℕ}


noncomputable section

open MeasureTheory ProbabilityTheory Real
open scoped NNReal


open BookProof.ChapterDisplacedThermalOverlap


theorem BookProof.ChapterDisplacedThermalMulti.dtOverlapMulti_eq (nbar : ℝ≥0) (a b : EuclideanSpace ℝ (Fin n)) :
    dtOverlapMulti nbar a b
      = Real.exp (-‖a - b‖ ^ 2 / (4 * ((nbar : ℝ) + 1 / 2)))
        / (Real.sqrt (4 * π * ((nbar : ℝ) + 1 / 2))) ^ n := by sorry
