-- Generated from ChapterWignerSymmetryInfinite.lean — solution of BookProof.ChapterWignerSymmetryInfinite.key_pair
import Mathlib
import Definitions.Def_ChapterWignerSymmetryInfinite
import Theorems.Thm_BookProof_ChapterWignerSymmetryInfinite_coord_norm
import Theorems.Thm_BookProof_ChapterWignerSymmetryInfinite_modulus_add
import Theorems.Thm_BookProof_ChapterWignerSymmetryInfinite_exists_zeta
open BookProof.ChapterWignerSymmetryInfinite



open scoped InnerProductSpace ComplexConjugate


open BookProof.ChapterWignerSymmetry BookProof.ChapterOrthogonalSums

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}
variable {b : HilbertBasis ι ℂ E} {o : ι}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsWignerSymmetry T) {i : ι} (hi : i ≠ o) :
    (∀ x : E, conj (coord b T o o x) * coord b T o i x = conj ⟪b o, x⟫_ℂ * ⟪b i, x⟫_ℂ) ∨
    (∀ x : E, conj (coord b T o o x) * coord b T o i x
      = conj (conj ⟪b o, x⟫_ℂ * ⟪b i, x⟫_ℂ)) := by

  obtain ⟨zeta, hzeta, hrel⟩ := exists_zeta hT hi
  rcases hzeta with hz | hz
  · left
    intro x
    refine key_complex (coord b T o o x) (coord b T o i x) ⟪b o, x⟫_ℂ ⟪b i, x⟫_ℂ
      (coord_norm hT o x) (coord_norm hT i x) (modulus_add hT hi x) ?_
    have h := hrel x
    rw [hz] at h
    exact h
  · right
    intro x
    refine key_complex' (coord b T o o x) (coord b T o i x) ⟪b o, x⟫_ℂ ⟪b i, x⟫_ℂ
      (coord_norm hT o x) (coord_norm hT i x) (modulus_add hT hi x) ?_
    have h := hrel x
    rw [hz] at h
    exact h
