import Mathlib
import Definitions.Def_ChapterFockSecondQuantization

open BookProof.ChapterFockSecondQuantization




open Matrix
open scoped ComplexConjugate


variable {(j : ℕ) (u : FockAlg) : (creA j u).support ⊆ u.support.image (up j)}


theorem support_creA := by sorry
