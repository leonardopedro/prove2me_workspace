-- Generated from ChapterFreeFieldBornSignOrientationSubgroup.lean — theorem BookProof.ChapterFreeFieldBornSignOrientationSubgroup.mem_orientationPreservingSigns_iff_even
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignOrientationSubgroup
import Definitions.Def_ChapterA4
open BookProof.ChapterFreeFieldBornSignOrientationSubgroup

variable {n : ℕ}


open BookProof.ChapterFreeFieldBornSignHom
open BookProof.ChapterFreeFieldBornSignMatrix



theorem BookProof.ChapterFreeFieldBornSignOrientationSubgroup.mem_orientationPreservingSigns_iff_even (b : Fin n → Bool) :
    b ∈ orientationPreservingSigns n ↔ Even (flipCount b) := by sorry
