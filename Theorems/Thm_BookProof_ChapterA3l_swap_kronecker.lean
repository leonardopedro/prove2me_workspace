-- Generated from ChapterA3l.lean — theorem BookProof.ChapterA3l.swap_kronecker
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterA3j
import Mathlib
import Definitions.Def_ChapterA3l
import Definitions.Def_ChapterA3k
open BookProof.ChapterA3k
open BookProof.ChapterA3l


open Matrix
open scoped Kronecker


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3k

theorem BookProof.ChapterA3l.swap_kronecker (A B : Matrix (Fin 4) (Fin 4) ℂ) :
    swap * (A ⊗ₖ B) = (B ⊗ₖ A) * swap := by sorry
