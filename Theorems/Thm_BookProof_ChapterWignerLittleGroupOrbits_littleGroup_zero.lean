-- Generated from ChapterWignerLittleGroupOrbits.lean — theorem BookProof.ChapterWignerLittleGroupOrbits.littleGroup_zero
import Mathlib
import Definitions.Def_ChapterWignerLittleGroupOrbits
import Definitions.Def_ChapterLittleGroup
import Definitions.Def_ChapterWignerLittleGroup
open BookProof.ChapterLittleGroup
open BookProof.ChapterWignerLittleGroup
open BookProof.ChapterWignerLittleGroupOrbits


open Matrix Complex
open scoped ComplexOrder


open BookProof.ChapterWignerLittleGroup

theorem BookProof.ChapterWignerLittleGroupOrbits.littleGroup_zero :
    littleGroup (fun _ => 0) = {A : Matrix (Fin 2) (Fin 2) ℂ | A.det = 1} := by sorry
