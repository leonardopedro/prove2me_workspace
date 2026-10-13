-- Generated from ChapterWignerOrbitClassification.lean — solution of BookProof.ChapterWignerOrbitClassification.negMom_negMom
import Mathlib
import Definitions.Def_ChapterWignerOrbitClassification
import Definitions.Def_ChapterWignerLittleGroup
import Definitions.Def_ChapterWignerLittleGroupOrbits
open BookProof.ChapterWignerOrbitClassification



open Matrix Complex


open BookProof.ChapterWignerLittleGroup BookProof.ChapterWignerLittleGroupOrbits

set_option maxHeartbeats 1000000 in
theorem solution (p : Fin 4 → ℝ) : negMom (negMom p) = p := by

  funext i; simp [negMom]
