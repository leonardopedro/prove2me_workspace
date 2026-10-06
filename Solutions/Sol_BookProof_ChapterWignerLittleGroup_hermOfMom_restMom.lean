-- Generated from ChapterWignerLittleGroup.lean — solution of BookProof.ChapterWignerLittleGroup.hermOfMom_restMom
import Mathlib
import Definitions.Def_ChapterWignerLittleGroup
open BookProof.ChapterWignerLittleGroup



open Matrix Complex

set_option maxHeartbeats 1000000 in
theorem solution (m : ℝ) :
    hermOfMom (restMom m) = (m : ℂ) • (1 : Matrix (Fin 2) (Fin 2) ℂ) := by

  ext i j
  fin_cases i <;> fin_cases j <;> simp [hermOfMom, restMom]
