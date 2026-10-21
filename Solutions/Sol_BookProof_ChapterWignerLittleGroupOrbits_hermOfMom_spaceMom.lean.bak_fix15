-- Generated from ChapterWignerLittleGroupOrbits.lean — solution of BookProof.ChapterWignerLittleGroupOrbits.hermOfMom_spaceMom
import Mathlib
import Definitions.Def_ChapterWignerLittleGroupOrbits
open BookProof.ChapterWignerLittleGroupOrbits



open Matrix Complex
open scoped ComplexOrder


open BookProof.ChapterWignerLittleGroup

set_option maxHeartbeats 1000000 in
theorem solution : hermOfMom spaceMom = !![(1 : ℂ), 0; 0, -1] := by

  ext i j
  fin_cases i <;> fin_cases j <;> simp [hermOfMom, spaceMom]
