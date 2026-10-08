-- Generated from ChapterWignerSymmetry.lean — theorem BookProof.ChapterWignerSymmetry.modulus_add
import Mathlib
import Definitions.Def_ChapterWignerSymmetry
open BookProof.ChapterWignerSymmetry


open scoped InnerProductSpace ComplexConjugate
open Finset


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


variable {T : E → E}

variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {S : (ι → ℂ) → (ι → ℂ)} {o : ι}

theorem BookProof.ChapterWignerSymmetry.modulus_add (hS : WignerCoord S o) {i : ι} (hi : i ≠ o) (v : ι → ℂ) :
    ‖S v o + S v i‖ = ‖v o + v i‖ := by sorry
