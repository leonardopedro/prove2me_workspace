-- Generated from ChapterAbelianVonNeumannFinite.lean — theorem BookProof.ChapterAbelianVonNeumannFinite.conjDiagonal_injective
import Mathlib
import Definitions.Def_ChapterAbelianVonNeumannFinite
import Definitions.Def_ChapterAbelianDiagonal
open BookProof.AbelianDiagonal
open BookProof.ChapterAbelianVonNeumannFinite


open Matrix


variable {n : Type*} [Fintype n] [DecidableEq n]


theorem BookProof.ChapterAbelianVonNeumannFinite.conjDiagonal_injective (U : Matrix.unitaryGroup n ℂ) :
    Function.Injective (conjDiagonal U) := by sorry
