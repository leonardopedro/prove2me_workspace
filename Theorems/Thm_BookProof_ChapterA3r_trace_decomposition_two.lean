-- Generated from ChapterA3r.lean — theorem BookProof.ChapterA3r.trace_decomposition_two
import Definitions.Def_ChapterA3q
import Mathlib
import Definitions.Def_ChapterA3r
import Definitions.Def_ChapterA3l
import Definitions.Def_ChapterA3n
import Definitions.Def_ChapterA3o
open BookProof.ChapterA3l
open BookProof.ChapterA3n
open BookProof.ChapterA3o
open BookProof.ChapterA3r


open Matrix
open scoped BigOperators


open BookProof.ChapterA3n BookProof.ChapterA3o BookProof.ChapterA3q

theorem BookProof.ChapterA3r.trace_decomposition_two :
    Matrix.trace (projSym 2) + Matrix.trace (projAnti 2)
        + Matrix.trace (projMixed 2) = 16 := by sorry
