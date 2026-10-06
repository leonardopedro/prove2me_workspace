-- Generated from ChapterDisplacedThermalMulti.lean — theorem BookProof.ChapterDisplacedThermalMulti.dtBornMulti_eq_softmax
import Mathlib
import Definitions.Def_ChapterDisplacedThermalMulti
import Definitions.Def_ChapterDisplacedThermalOverlap
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterDisplacedThermalOverlap
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterDisplacedThermalMulti

variable {n m : ℕ}


noncomputable section

open MeasureTheory ProbabilityTheory Real
open scoped NNReal


open BookProof.ChapterDisplacedThermalOverlap


theorem BookProof.ChapterDisplacedThermalMulti.dtBornMulti_eq_softmax (nbar : ℝ≥0) (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (j : Fin m) :
    dtBornMulti nbar q k j
      = BookProof.ChapterSoftmaxSharpness.scoreSoftmax (inverseTemperature nbar)
          (fun l => -‖q - k l‖ ^ 2) j := by sorry
