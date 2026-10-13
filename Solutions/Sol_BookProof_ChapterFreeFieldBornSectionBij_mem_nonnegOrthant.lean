-- Generated from ChapterFreeFieldBornSectionBij.lean — solution of BookProof.ChapterFreeFieldBornSectionBij.mem_nonnegOrthant
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSectionBij
import Definitions.Def_ChapterFreeFieldGaussian
import Definitions.Def_ChapterFreeFieldSphere
import Definitions.Def_ChapterFreeFieldSphereSupport
import Definitions.Def_ChapterFreeFieldBorn
import Definitions.Def_ChapterFreeFieldBornSurj
open BookProof.ChapterFreeFieldBornSectionBij



open MeasureTheory
open BookProof.ChapterFreeFieldGaussian BookProof.ChapterFreeFieldSphere
open BookProof.ChapterFreeFieldSphereSupport BookProof.ChapterFreeFieldBorn
open BookProof.ChapterFreeFieldBornSurj


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {x : EuclideanSpace ℝ (Fin n)} :
    x ∈ nonnegOrthant n ↔ ∀ k, 0 ≤ x k := Iff.rfl
