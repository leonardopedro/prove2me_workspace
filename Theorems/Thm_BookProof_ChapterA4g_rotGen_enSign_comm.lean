-- Generated from ChapterA4g.lean — theorem BookProof.ChapterA4g.rotGen_enSign_comm
import Definitions.Def_ChapterA3
import Mathlib
import Definitions.Def_ChapterA4g
import Definitions.Def_ChapterA4e
import Definitions.Def_ChapterA5
import Definitions.Def_ChapterA4
open BookProof.ChapterA4e
open BookProof.ChapterA5
open BookProof.ChapterA4g


open Matrix
open scoped ComplexConjugate


open BookProof.ChapterA3

theorem BookProof.ChapterA4g.rotGen_enSign_comm (i j : Fin 3) :
    rotGen i j * enSign = enSign * rotGen i j := by sorry
