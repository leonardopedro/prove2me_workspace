-- Generated from ChapterSmBrstGhost.lean — theorem BookProof.SmBrstGhost.matterGen_lie
import Definitions.Def_ChapterBRSTNilpotent
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterYangMillsSU3
open BookProof.SmCar
open BookProof.YangMillsSU3
open BookProof.SmBrstGhost



open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

variable {m : ℕ}
variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {N : ℕ}

theorem BookProof.SmBrstGhost.matterGen_lie {m : ℕ} {T : Fin 12 → Matrix (Fin m) (Fin m) ℂ}
    {f : Fin 12 → Fin 12 → Fin 12 → ℝ} (hT : ClosesWithStructureConstants T f) (a b : Fin 12) :
    matterGen m T a * matterGen m T b - matterGen m T b * matterGen m T a
      = ∑ c, f a b c • matterGen m T c := by sorry
