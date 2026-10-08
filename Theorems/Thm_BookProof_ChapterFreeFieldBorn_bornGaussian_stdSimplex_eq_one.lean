-- Generated from ChapterFreeFieldBorn.lean — theorem BookProof.ChapterFreeFieldBorn.bornGaussian_stdSimplex_eq_one
import Definitions.Def_ChapterFreeFieldGaussian
import Definitions.Def_ChapterFreeFieldSphere
import Definitions.Def_ChapterFreeFieldSphereSupport
import Mathlib
import Definitions.Def_ChapterFreeFieldBorn
open BookProof.ChapterFreeFieldBorn


open MeasureTheory
open BookProof.ChapterFreeFieldGaussian BookProof.ChapterFreeFieldSphere
open BookProof.ChapterFreeFieldSphereSupport


variable {n : ℕ}


theorem BookProof.ChapterFreeFieldBorn.bornGaussian_stdSimplex_eq_one (hn : 0 < n) :
    ((sphereGaussian n).map bornMap) (stdSimplex ℝ (Fin n)) = 1 := by sorry
