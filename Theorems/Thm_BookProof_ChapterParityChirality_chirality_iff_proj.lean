-- Generated from ChapterParityChirality.lean — theorem BookProof.ChapterParityChirality.chirality_iff_proj
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterParity
import Definitions.Def_ChapterParitySU2
import Mathlib
import Definitions.Def_ChapterParityChirality
open BookProof.ChapterParityChirality


open Matrix
open scoped Kronecker


open BookProof.ChapterA3
open BookProof.ChapterParity
open BookProof.ChapterParitySU2

theorem BookProof.ChapterParityChirality.chirality_iff_proj (v : Fin 2 × Fin 4 → ℂ) :
    chi *ᵥ v = -v ↔ QLProj *ᵥ v = v := by sorry
