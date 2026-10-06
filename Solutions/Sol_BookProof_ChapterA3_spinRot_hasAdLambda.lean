-- Generated from ChapterA3e.lean — solution of BookProof.ChapterA3.spinRot_hasAdLambda
import Mathlib
import Definitions.Def_ChapterA3e
import Theorems.Thm_BookProof_ChapterA3_hasAdLambda_of_intModel
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution (j : Fin 3) : HasAdLambda (spinRot j) (adRot j) := by

  have hconj : ∀ μ, spinRotZ j * mgammaZ μ - mgammaZ μ * spinRotZ j
      = ∑ ν, (adRotZ j) μ ν • mgammaZ ν := by
    fin_cases j <;> decide
  exact hasAdLambda_of_intModel (spinRotZ j) (adRotZ j) hconj
