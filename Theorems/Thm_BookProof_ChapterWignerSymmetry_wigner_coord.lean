-- Generated from ChapterWignerSymmetry.lean — theorem BookProof.ChapterWignerSymmetry.wigner_coord
import Mathlib
import Definitions.Def_ChapterWignerSymmetry
open BookProof.ChapterWignerSymmetry

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable {T : E → E}
variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {S : (ι → ℂ) → (ι → ℂ)} {o : ι}


open scoped InnerProductSpace ComplexConjugate
open Finset





theorem BookProof.ChapterWignerSymmetry.wigner_coord (hS : WignerCoord S o) :
    (∀ v, ∃ lam : ℂ, ‖lam‖ = 1 ∧ ∀ k, S v k = lam * v k) ∨
    (∀ v, ∃ lam : ℂ, ‖lam‖ = 1 ∧ ∀ k, S v k = lam * conj (v k)) := by sorry
