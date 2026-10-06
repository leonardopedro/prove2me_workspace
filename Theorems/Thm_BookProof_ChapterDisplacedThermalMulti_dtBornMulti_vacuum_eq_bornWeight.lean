-- Generated from ChapterDisplacedThermalMulti.lean — theorem BookProof.ChapterDisplacedThermalMulti.dtBornMulti_vacuum_eq_bornWeight
import Mathlib
import Definitions.Def_ChapterDisplacedThermalMulti
import Definitions.Def_ChapterDisplacedThermalOverlap
import Definitions.Def_ChapterSoftmaxBorn
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterDisplacedThermalOverlap
open BookProof.ChapterSoftmaxBorn
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterDisplacedThermalMulti

variable {n m : ℕ}


noncomputable section

open MeasureTheory ProbabilityTheory Real
open scoped NNReal


open BookProof.ChapterDisplacedThermalOverlap


theorem BookProof.ChapterDisplacedThermalMulti.dtBornMulti_vacuum_eq_bornWeight (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (j : Fin m) :
    dtBornMulti 0 (Real.sqrt 2 • q) (fun l => Real.sqrt 2 • k l) j
      = BookProof.ChapterSoftmaxBorn.bornWeight q k j := by sorry
