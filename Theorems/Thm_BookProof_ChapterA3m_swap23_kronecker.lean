-- Generated from ChapterA3m.lean — theorem BookProof.ChapterA3m.swap23_kronecker
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterA3j
import Definitions.Def_ChapterA3k
import Definitions.Def_ChapterA3l
import Mathlib
import Definitions.Def_ChapterA3m
open BookProof.ChapterA3m


open Matrix
open scoped Kronecker


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3k BookProof.ChapterA3l

theorem BookProof.ChapterA3m.swap23_kronecker (A B C : Matrix (Fin 4) (Fin 4) ℂ) :
    swap23 * ((A ⊗ₖ B) ⊗ₖ C) = ((A ⊗ₖ C) ⊗ₖ B) * swap23 := by sorry
