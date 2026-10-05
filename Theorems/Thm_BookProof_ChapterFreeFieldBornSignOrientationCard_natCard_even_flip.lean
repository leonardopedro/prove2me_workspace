-- Generated from ChapterFreeFieldBornSignOrientationCard.lean — theorem BookProof.ChapterFreeFieldBornSignOrientationCard.natCard_even_flip
import Definitions.Def_ChapterFreeFieldBornSignHom
import Definitions.Def_ChapterFreeFieldBornSignMatrix
import Definitions.Def_ChapterFreeFieldBornSignOrientation
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignOrientationCard
open BookProof.ChapterFreeFieldBornSignOrientationCard


open BookProof.ChapterFreeFieldBornSignHom
open BookProof.ChapterFreeFieldBornSignMatrix
open BookProof.ChapterFreeFieldBornSignOrientation

theorem BookProof.ChapterFreeFieldBornSignOrientationCard.natCard_even_flip (n : ℕ) :
    Nat.card {b : Fin (n + 1) → Bool // Even (flipCount b)} = 2 ^ n := by sorry
