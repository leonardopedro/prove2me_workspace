-- Generated from ChapterA3n.lean — theorem BookProof.ChapterA3n.tensorPow_one
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterA3j
import Mathlib
import Definitions.Def_ChapterA3n
open BookProof.ChapterA3n


open Matrix
open scoped BigOperators


open BookProof.ChapterA3 BookProof.ChapterA3j

theorem BookProof.ChapterA3n.tensorPow_one {N : ℕ} :
    tensorPow (N := N) (fun _ => (1 : Matrix (Fin 4) (Fin 4) ℂ)) = 1 := by sorry
