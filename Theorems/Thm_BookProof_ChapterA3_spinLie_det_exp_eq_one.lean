-- Generated from ChapterA3f.lean — theorem BookProof.ChapterA3.spinLie_det_exp_eq_one
import Mathlib
import Definitions.Def_ChapterA3f
import Definitions.Def_ChapterA3e
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix NormedSpace
open scoped Norms.Operator


variable {n : ℕ}


theorem BookProof.ChapterA3.spinLie_det_exp_eq_one {G : Matrix (Fin 4) (Fin 4) ℝ} (hG : IsSpinLie G) :
    (NormedSpace.exp G).det = 1 := by sorry
