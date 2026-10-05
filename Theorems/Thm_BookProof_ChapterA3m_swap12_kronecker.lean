-- Generated from ChapterA3m.lean — theorem BookProof.ChapterA3m.swap12_kronecker
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterA3j
import Mathlib
import Definitions.Def_ChapterA3m
import Definitions.Def_ChapterA3k
import Definitions.Def_ChapterA3l
open BookProof.ChapterA3k
open BookProof.ChapterA3l
open BookProof.ChapterA3m


open Matrix
open scoped Kronecker


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3k BookProof.ChapterA3l

theorem BookProof.ChapterA3m.swap12_kronecker (A B C : Matrix (Fin 4) (Fin 4) ℂ) :
    swap12 * ((A ⊗ₖ B) ⊗ₖ C) = ((B ⊗ₖ A) ⊗ₖ C) * swap12 := by sorry
