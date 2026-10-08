-- Generated from ChapterA3f.lean — theorem BookProof.ChapterA3.det_exp_eq_exp_trace
import Mathlib
import Definitions.Def_ChapterA3f
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix NormedSpace
open scoped Norms.Operator


variable {n : ℕ}


theorem BookProof.ChapterA3.det_exp_eq_exp_trace (A : Matrix (Fin n) (Fin n) ℝ) :
    (NormedSpace.exp A).det = Real.exp A.trace := by sorry
