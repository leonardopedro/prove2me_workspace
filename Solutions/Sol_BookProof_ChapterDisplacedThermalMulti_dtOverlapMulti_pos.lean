-- Generated from ChapterDisplacedThermalMulti.lean — solution of BookProof.ChapterDisplacedThermalMulti.dtOverlapMulti_pos
import Mathlib
import Definitions.Def_ChapterDisplacedThermalMulti
import Theorems.Thm_BookProof_ChapterDisplacedThermalOverlap_dtOverlap_pos
open BookProof.ChapterDisplacedThermalMulti



noncomputable section

open MeasureTheory ProbabilityTheory Real
open scoped NNReal


open BookProof.ChapterDisplacedThermalOverlap

variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (nbar : ℝ≥0) (a b : EuclideanSpace ℝ (Fin n)) :
    0 < dtOverlapMulti nbar a b := Finset.prod_pos fun i _ => dtOverlap_pos nbar (a i) (b i)
