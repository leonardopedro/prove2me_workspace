-- Generated from ChapterFreeFieldBornSignOrientationSubgroup.lean — theorem BookProof.ChapterFreeFieldBornSignOrientationSubgroup.sub_mem_orientationPreservingSigns_iff
import Definitions.Def_ChapterFreeFieldBornSignHom
import Definitions.Def_ChapterFreeFieldBornSignMatrix
import Definitions.Def_ChapterFreeFieldBornSignOrientation
import Definitions.Def_ChapterFreeFieldBornSignOrientationKernel
import Definitions.Def_ChapterFreeFieldBornSignOrientationCard
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignOrientationSubgroup
open BookProof.ChapterFreeFieldBornSignOrientationSubgroup


open BookProof.ChapterFreeFieldBornSignHom
open BookProof.ChapterFreeFieldBornSignMatrix
open BookProof.ChapterFreeFieldBornSignOrientation
open BookProof.ChapterFreeFieldBornSignOrientationKernel
open BookProof.ChapterFreeFieldBornSignOrientationCard


variable {n : ℕ}


theorem BookProof.ChapterFreeFieldBornSignOrientationSubgroup.sub_mem_orientationPreservingSigns_iff (b₁ b₂ : Fin n → Bool) :
    b₁ - b₂ ∈ orientationPreservingSigns n ↔
      (b₁ ∈ orientationPreservingSigns n ↔
       b₂ ∈ orientationPreservingSigns n) := by sorry
