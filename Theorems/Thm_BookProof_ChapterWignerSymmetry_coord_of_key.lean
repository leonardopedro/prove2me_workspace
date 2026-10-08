-- Generated from ChapterWignerSymmetry.lean — theorem BookProof.ChapterWignerSymmetry.coord_of_key
import Mathlib
import Definitions.Def_ChapterWignerSymmetry
open BookProof.ChapterWignerSymmetry


open scoped InnerProductSpace ComplexConjugate
open Finset


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


variable {T : E → E}

variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {S : (ι → ℂ) → (ι → ℂ)} {o : ι}

theorem BookProof.ChapterWignerSymmetry.coord_of_key (hS : WignerCoord S o) (κ : ℂ →+* ℂ) (hκn : ∀ z, ‖κ z‖ = ‖z‖)
    (hκc : ∀ z, κ (conj z) = conj (κ z))
    (hkey : ∀ i, i ≠ o → ∀ v, conj (S v o) * S v i = κ (conj (v o) * v i)) (v : ι → ℂ) :
    ∃ lam : ℂ, ‖lam‖ = 1 ∧ ∀ k, S v k = lam * κ (v k) := by sorry
