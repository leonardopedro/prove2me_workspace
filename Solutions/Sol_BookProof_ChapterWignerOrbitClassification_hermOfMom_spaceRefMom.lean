-- Generated from ChapterWignerOrbitClassification.lean — solution of BookProof.ChapterWignerOrbitClassification.hermOfMom_spaceRefMom
import Mathlib
import Definitions.Def_ChapterWignerOrbitClassification
open BookProof.ChapterWignerOrbitClassification



open Matrix Complex


open BookProof.ChapterWignerLittleGroup BookProof.ChapterWignerLittleGroupOrbits

set_option maxHeartbeats 1000000 in
theorem solution (m : ℝ) :
    hermOfMom (spaceRefMom m) = !![(m : ℂ), 0; 0, -(m : ℂ)] := by

  ext i j
  fin_cases i <;> fin_cases j <;> simp [hermOfMom, spaceRefMom]
