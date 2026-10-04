-- Generated from ChapterA3f.lean — theorem BookProof.ChapterA3.differentiable_det
import Mathlib
import Definitions.Def_ChapterA3f
import Definitions.Def_ChapterA3
open BookProof.ChapterA3

variable {n : ℕ}


open Matrix NormedSpace
open scoped Norms.Operator



theorem BookProof.ChapterA3.differentiable_det :
    Differentiable ℝ (Matrix.det : Matrix (Fin n) (Fin n) ℝ → ℝ) := by sorry
