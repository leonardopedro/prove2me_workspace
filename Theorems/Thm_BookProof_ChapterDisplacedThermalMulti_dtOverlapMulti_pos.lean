-- Generated from ChapterDisplacedThermalMulti.lean — theorem BookProof.ChapterDisplacedThermalMulti.dtOverlapMulti_pos
import Mathlib
import Definitions.Def_ChapterDisplacedThermalMulti
import Definitions.Def_ChapterDisplacedThermalOverlap
open BookProof.ChapterDisplacedThermalOverlap
open BookProof.ChapterDisplacedThermalMulti


noncomputable section

open MeasureTheory ProbabilityTheory Real
open scoped NNReal


open BookProof.ChapterDisplacedThermalOverlap

variable {n m : ℕ}


theorem BookProof.ChapterDisplacedThermalMulti.dtOverlapMulti_pos (nbar : ℝ≥0) (a b : EuclideanSpace ℝ (Fin n)) :
    0 < dtOverlapMulti nbar a b := by sorry
