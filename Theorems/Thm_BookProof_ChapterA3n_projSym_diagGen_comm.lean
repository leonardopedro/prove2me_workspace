-- Generated from ChapterA3n.lean — theorem BookProof.ChapterA3n.projSym_diagGen_comm
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterA3j
import Mathlib
import Definitions.Def_ChapterA3n
import Definitions.Def_ChapterA3l
open BookProof.ChapterA3l
open BookProof.ChapterA3n


open Matrix
open scoped BigOperators


open BookProof.ChapterA3 BookProof.ChapterA3j

theorem BookProof.ChapterA3n.projSym_diagGen_comm {N : ℕ} (A : Matrix (Fin 4) (Fin 4) ℂ) :
    projSym N * diagGen A = diagGen A * projSym N := by sorry
