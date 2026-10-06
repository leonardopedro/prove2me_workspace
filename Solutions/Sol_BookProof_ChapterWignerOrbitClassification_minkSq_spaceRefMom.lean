-- Generated from ChapterWignerOrbitClassification.lean — solution of BookProof.ChapterWignerOrbitClassification.minkSq_spaceRefMom
import Mathlib
import Definitions.Def_ChapterWignerOrbitClassification
open BookProof.ChapterWignerOrbitClassification



open Matrix Complex


open BookProof.ChapterWignerLittleGroup BookProof.ChapterWignerLittleGroupOrbits

set_option maxHeartbeats 1000000 in
theorem solution (m : ℝ) : minkSq (spaceRefMom m) = -m ^ 2 := by

  simp [minkSq, spaceRefMom]
