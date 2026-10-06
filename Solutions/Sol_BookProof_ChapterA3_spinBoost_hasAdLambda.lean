-- Generated from ChapterA3e.lean — solution of BookProof.ChapterA3.spinBoost_hasAdLambda
import Mathlib
import Definitions.Def_ChapterA3e
import Theorems.Thm_BookProof_ChapterA3_hasAdLambda_of_intModel
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution (j : Fin 3) : HasAdLambda (spinBoost j) (adBoost j) := by

  have hconj : ∀ μ, spinBoostZ j * mgammaZ μ - mgammaZ μ * spinBoostZ j
      = ∑ ν, (adBoostZ j) μ ν • mgammaZ ν := by
    fin_cases j <;> decide
  exact hasAdLambda_of_intModel (spinBoostZ j) (adBoostZ j) hconj
