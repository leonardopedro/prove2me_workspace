-- Generated from ChapterBRSTNilpotent.lean — theorem BookProof.BRSTNilpotent.chi_swap4
import Mathlib
import Definitions.Def_ChapterBRSTNilpotent
open BookProof.BRSTNilpotent



variable {R : Type*} [Ring R] [Algebra ℝ R]
variable {n : ℕ}


theorem BookProof.BRSTNilpotent.chi_swap4 (χ β : Fin n → R) (hCAR : GhostCAR χ β) (a b c d : Fin n) :
    χ a * χ b * χ c * χ d = χ c * χ d * χ a * χ b := by sorry
