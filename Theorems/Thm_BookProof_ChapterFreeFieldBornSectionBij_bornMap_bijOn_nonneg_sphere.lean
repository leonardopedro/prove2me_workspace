-- Generated from ChapterFreeFieldBornSectionBij.lean — theorem BookProof.ChapterFreeFieldBornSectionBij.bornMap_bijOn_nonneg_sphere
import Definitions.Def_ChapterFreeFieldGaussian
import Definitions.Def_ChapterFreeFieldSphere
import Definitions.Def_ChapterFreeFieldSphereSupport
import Definitions.Def_ChapterFreeFieldBorn
import Definitions.Def_ChapterFreeFieldBornSurj
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSectionBij
open BookProof.ChapterFreeFieldBornSectionBij

variable {n : ℕ}


open MeasureTheory
open BookProof.ChapterFreeFieldGaussian BookProof.ChapterFreeFieldSphere
open BookProof.ChapterFreeFieldSphereSupport BookProof.ChapterFreeFieldBorn
open BookProof.ChapterFreeFieldBornSurj



theorem BookProof.ChapterFreeFieldBornSectionBij.bornMap_bijOn_nonneg_sphere :
    Set.BijOn (bornMap : EuclideanSpace ℝ (Fin n) → _)
      (Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1 ∩ nonnegOrthant n)
      (stdSimplex ℝ (Fin n)) := by sorry
