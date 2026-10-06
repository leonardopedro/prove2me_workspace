-- Generated from ChapterWignerOrbitClassification.lean — theorem BookProof.ChapterWignerOrbitClassification.orbit_classification
import Definitions.Def_ChapterWignerLittleGroupOrbits
import Mathlib
import Definitions.Def_ChapterWignerOrbitClassification
import Definitions.Def_ChapterGravityProjector
import Definitions.Def_ChapterWignerLittleGroup
open BookProof.ChapterGravityProjector
open BookProof.ChapterWignerLittleGroup
open BookProof.ChapterWignerOrbitClassification


open Matrix Complex


open BookProof.ChapterWignerLittleGroup BookProof.ChapterWignerLittleGroupOrbits

theorem BookProof.ChapterWignerOrbitClassification.orbit_classification (p q : Fin 4 → ℝ) :
    SameOrbit p q ↔ minkSq p = minkSq q ∧
      (minkSq p < 0 ∨ ((∀ i, p i = 0) ∧ (∀ i, q i = 0)) ∨ (0 < p 0 ∧ 0 < q 0) ∨
        (p 0 < 0 ∧ q 0 < 0)) := by sorry
