-- Generated from ChapterBRSTNilpotent.lean — theorem BookProof.BRSTNilpotent.chi_cyc3
import Mathlib
import Definitions.Def_ChapterBRSTNilpotent
open BookProof.BRSTNilpotent



variable {R : Type*} [Ring R] [Algebra ℝ R]
variable {n : ℕ}


theorem BookProof.BRSTNilpotent.chi_cyc3 (χ β : Fin n → R) (hCAR : GhostCAR χ β) (a b c : Fin n) :
    χ a * χ b * χ c = χ b * χ c * χ a := by sorry
