-- Generated from ChapterWignerSymmetryInfinite.lean — theorem BookProof.ChapterWignerSymmetryInfinite.coord_of_key_ne_zero
import Definitions.Def_ChapterOrthogonalSums
import Mathlib
import Definitions.Def_ChapterWignerSymmetryInfinite
import Definitions.Def_ChapterWignerSymmetry
open BookProof.ChapterWignerSymmetry
open BookProof.ChapterWignerSymmetryInfinite

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}
variable {b : HilbertBasis ι ℂ E} {o : ι}
variable {i j : ι}
variable (κ : ℂ →+* ℂ)


open scoped InnerProductSpace ComplexConjugate


open BookProof.ChapterWignerSymmetry BookProof.ChapterOrthogonalSums


theorem BookProof.ChapterWignerSymmetryInfinite.coord_of_key_ne_zero (hT : IsWignerSymmetry T) (hκn : ∀ z, ‖κ z‖ = ‖z‖)
    (hκc : ∀ z, κ (conj z) = conj (κ z))
    (hkey : ∀ i, i ≠ o → ∀ x : E,
      conj (coord b T o o x) * coord b T o i x = κ (conj ⟪b o, x⟫_ℂ * ⟪b i, x⟫_ℂ))
    {x : E} (hx : ⟪b o, x⟫_ℂ ≠ 0) :
    ∃ lam : ℂ, ‖lam‖ = 1 ∧ ∀ k, coord b T o k x = lam * κ ⟪b k, x⟫_ℂ := by sorry
