-- Generated from ChapterFreeFieldBornSurj.lean — solution of BookProof.ChapterFreeFieldBornSurj.bornSection_apply
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSurj
import Definitions.Def_ChapterFreeFieldGaussian
import Definitions.Def_ChapterFreeFieldSphere
import Definitions.Def_ChapterFreeFieldSphereSupport
import Definitions.Def_ChapterFreeFieldBorn
open BookProof.ChapterFreeFieldBornSurj



open MeasureTheory
open BookProof.ChapterFreeFieldGaussian BookProof.ChapterFreeFieldSphere
open BookProof.ChapterFreeFieldSphereSupport BookProof.ChapterFreeFieldBorn


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in

theorem solution (p : Fin n → ℝ) (k : Fin n) :
    bornSection p k = Real.sqrt (p k) := by rfl
