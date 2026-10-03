-- Generated from ChapterWignerSymmetryInfinite.lean — theorem BookProof.ChapterWignerSymmetryInfinite.coord_of_key
import Mathlib
import Definitions.Def_ChapterWignerSymmetryInfinite
import Definitions.Def_ChapterWignerSymmetry
import Definitions.Def_ChapterA4
open BookProof.ChapterWignerSymmetry

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}
variable {b : HilbertBasis ι ℂ E} {o : ι}
variable {i j : ι}
variable (κ : ℂ →+* ℂ)


open scoped InnerProductSpace ComplexConjugate




theorem BookProof.ChapterWignerSymmetryInfinite.coord_of_key (hT : IsWignerSymmetry T) (hκn : ∀ z, ‖κ z‖ = ‖z‖)
    (hκc : ∀ z, κ (conj z) = conj (κ z))
    (hkey : ∀ i, i ≠ o → ∀ x : E,
      conj (coord b T o o x) * coord b T o i x = κ (conj ⟪b o, x⟫_ℂ * ⟪b i, x⟫_ℂ))
    (x : E) : ∃ lam : ℂ, ‖lam‖ = 1 ∧ ∀ k, coord b T o k x = lam * κ ⟪b k, x⟫_ℂ := by sorry
