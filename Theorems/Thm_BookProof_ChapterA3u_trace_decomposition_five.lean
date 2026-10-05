-- Generated from ChapterA3u.lean — theorem BookProof.ChapterA3u.trace_decomposition_five
import Definitions.Def_ChapterA3q
import Definitions.Def_ChapterA3r
import Mathlib
import Definitions.Def_ChapterA3u
import Definitions.Def_ChapterA3l
import Definitions.Def_ChapterA3n
import Definitions.Def_ChapterA3o
open BookProof.ChapterA3l
open BookProof.ChapterA3n
open BookProof.ChapterA3o
open BookProof.ChapterA3u


open Matrix
open scoped BigOperators


open BookProof.ChapterA3n BookProof.ChapterA3o BookProof.ChapterA3q
open BookProof.ChapterA3r

theorem BookProof.ChapterA3u.trace_decomposition_five :
    Matrix.trace (projSym 5) + Matrix.trace (projAnti 5)
        + Matrix.trace (projMixed 5) = 1024 := by sorry
