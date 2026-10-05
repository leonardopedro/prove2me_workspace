-- Generated from ChapterBRSTNilpotent.lean — theorem BookProof.BRSTNilpotent.beta_move
import Mathlib
import Definitions.Def_ChapterBRSTNilpotent
open BookProof.BRSTNilpotent

variable {R : Type*} [Ring R] [Algebra ℝ R]
variable {n : ℕ}




theorem BookProof.BRSTNilpotent.beta_move (χ β : Fin n → R) (hCAR : GhostCAR χ β) (e d g : Fin n) :
    β e * (χ d * χ g)
      = (if e = d then χ g else 0) - (if e = g then χ d else 0) + χ d * χ g * β e := by sorry
