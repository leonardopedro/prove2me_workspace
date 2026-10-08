-- Generated from ChapterDisplacedThermalMulti.lean — theorem BookProof.ChapterDisplacedThermalMulti.norm_sq_eq_sum
import Definitions.Def_ChapterDisplacedThermalOverlap
import Mathlib
import Definitions.Def_ChapterDisplacedThermalMulti
open BookProof.ChapterDisplacedThermalMulti


noncomputable section

open MeasureTheory ProbabilityTheory Real
open scoped NNReal


open BookProof.ChapterDisplacedThermalOverlap

variable {n m : ℕ}


theorem BookProof.ChapterDisplacedThermalMulti.norm_sq_eq_sum (a b : EuclideanSpace ℝ (Fin n)) :
    ‖a - b‖ ^ 2 = ∑ i, (a i - b i) ^ 2 := by sorry
