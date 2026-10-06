-- Generated from ChapterWignerOrbitClassification.lean — solution of BookProof.ChapterWignerOrbitClassification.hermOfMom_negMom
import Mathlib
import Definitions.Def_ChapterWignerOrbitClassification
open BookProof.ChapterWignerOrbitClassification



open Matrix Complex


open BookProof.ChapterWignerLittleGroup BookProof.ChapterWignerLittleGroupOrbits

set_option maxHeartbeats 1000000 in
theorem solution (p : Fin 4 → ℝ) : hermOfMom (negMom p) = -hermOfMom p := by

  ext i j
  fin_cases i <;> fin_cases j <;> simp [hermOfMom, negMom] <;> ring
