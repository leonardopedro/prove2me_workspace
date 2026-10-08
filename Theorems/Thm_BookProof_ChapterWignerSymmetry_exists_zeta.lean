-- Generated from ChapterWignerSymmetry.lean — theorem BookProof.ChapterWignerSymmetry.exists_zeta
import Mathlib
import Definitions.Def_ChapterWignerSymmetry
open BookProof.ChapterWignerSymmetry


open scoped InnerProductSpace ComplexConjugate
open Finset


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


variable {T : E → E}

variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {S : (ι → ℂ) → (ι → ℂ)} {o : ι}

theorem BookProof.ChapterWignerSymmetry.exists_zeta (hS : WignerCoord S o) {i : ι} (hi : i ≠ o) :
    ∃ ζ : ℂ, (ζ = Complex.I ∨ ζ = -Complex.I) ∧
      ∀ v, ‖conj (S v o) + ζ * conj (S v i)‖ = ‖conj (v o) + Complex.I * conj (v i)‖ := by sorry
