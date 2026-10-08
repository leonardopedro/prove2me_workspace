-- Generated from ChapterSmBrstGhost.lean — theorem BookProof.SmBrstGhost.embedMatter_sum
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

theorem BookProof.SmBrstGhost.embedMatter_sum {m : ℕ} {ι : Type*} (s : Finset ι) (M : ι → Matrix (Fin m) (Fin m) ℂ) :
    embedMatter m (∑ t ∈ s, M t) = ∑ t ∈ s, embedMatter m (M t) := by sorry
