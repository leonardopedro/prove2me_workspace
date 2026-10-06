-- Generated from ChapterA3n.lean — theorem BookProof.ChapterA3n.tensorPow_mul
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterA3j
import Mathlib
import Definitions.Def_ChapterA3n
open BookProof.ChapterA3n


open Matrix
open scoped BigOperators


open BookProof.ChapterA3 BookProof.ChapterA3j

theorem BookProof.ChapterA3n.tensorPow_mul {N : ℕ} (M M' : Fin N → Matrix (Fin 4) (Fin 4) ℂ) :
    tensorPow M * tensorPow M' = tensorPow (fun i => M i * M' i) := by sorry
