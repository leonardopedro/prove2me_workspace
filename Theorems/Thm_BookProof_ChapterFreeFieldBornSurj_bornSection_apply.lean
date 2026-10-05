-- Generated from ChapterFreeFieldBornSurj.lean — theorem BookProof.ChapterFreeFieldBornSurj.bornSection_apply
import Definitions.Def_ChapterFreeFieldGaussian
import Definitions.Def_ChapterFreeFieldSphere
import Definitions.Def_ChapterFreeFieldSphereSupport
import Definitions.Def_ChapterFreeFieldBorn
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSurj
open BookProof.ChapterFreeFieldBornSurj

variable {n : ℕ}


open MeasureTheory
open BookProof.ChapterFreeFieldGaussian BookProof.ChapterFreeFieldSphere
open BookProof.ChapterFreeFieldSphereSupport BookProof.ChapterFreeFieldBorn



theorem BookProof.ChapterFreeFieldBornSurj.bornSection_apply (p : Fin n → ℝ) (k : Fin n) :
    bornSection p k = Real.sqrt (p k) := by sorry
