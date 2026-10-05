-- Generated from ChapterA3q.lean — theorem BookProof.ChapterA3q.tensorPow_complete_reducibility
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterA3j
import Definitions.Def_ChapterA3p
import Mathlib
import Definitions.Def_ChapterA3q
import Definitions.Def_ChapterA3l
import Definitions.Def_ChapterA3n
import Definitions.Def_ChapterA3o
open BookProof.ChapterA3l
open BookProof.ChapterA3n
open BookProof.ChapterA3o
open BookProof.ChapterA3q


open Matrix
open scoped BigOperators


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3n BookProof.ChapterA3o
open BookProof.ChapterA3p

theorem BookProof.ChapterA3q.tensorPow_complete_reducibility {N : ℕ} (hN : 2 ≤ N) :
    projSym N + projAnti N + projMixed N = 1 ∧
    projSym N * projSym N = projSym N ∧
    projAnti N * projAnti N = projAnti N ∧
    projMixed N * projMixed N = projMixed N ∧
    projSym N * projAnti N = 0 ∧ projAnti N * projSym N = 0 ∧
    projSym N * projMixed N = 0 ∧ projMixed N * projSym N = 0 ∧
    projAnti N * projMixed N = 0 ∧ projMixed N * projAnti N = 0 := by sorry
