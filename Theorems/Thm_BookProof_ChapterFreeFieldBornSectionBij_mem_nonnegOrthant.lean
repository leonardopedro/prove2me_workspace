-- Generated from ChapterFreeFieldBornSectionBij.lean — theorem BookProof.ChapterFreeFieldBornSectionBij.mem_nonnegOrthant
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



theorem BookProof.ChapterFreeFieldBornSectionBij.mem_nonnegOrthant {x : EuclideanSpace ℝ (Fin n)} :
    x ∈ nonnegOrthant n ↔ ∀ k, 0 ≤ x k := by sorry
