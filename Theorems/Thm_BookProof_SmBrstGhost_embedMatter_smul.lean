-- Generated from ChapterSmBrstGhost.lean — theorem BookProof.SmBrstGhost.embedMatter_smul
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterYangMillsSU3
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
open BookProof.SmBrstGhost



open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

variable {m : ℕ}
variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {N : ℕ}

theorem BookProof.SmBrstGhost.embedMatter_smul (m : ℕ) (c : ℂ) (M : Matrix (Fin m) (Fin m) ℂ) :
    embedMatter m (c • M) = c • embedMatter m M := by sorry
