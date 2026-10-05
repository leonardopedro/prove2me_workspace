-- Generated from ChapterWignerSymmetryInfinite.lean — solution of BookProof.ChapterWignerSymmetryInfinite.wigner_symmetry_of_completeSpace
import Mathlib
import Definitions.Def_ChapterWignerSymmetryInfinite
import Theorems.Thm_BookProof_ChapterWignerSymmetryInfinite_wigner_symmetry_hilbert
open BookProof.ChapterWignerSymmetryInfinite



open scoped InnerProductSpace ComplexConjugate


open BookProof.ChapterWignerSymmetry BookProof.ChapterOrthogonalSums

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}
variable {b : HilbertBasis ι ℂ E} {o : ι}
variable {i j : ι}
variable (κ : ℂ →+* ℂ)

set_option maxHeartbeats 1000000 in
theorem solution [Nontrivial E] (hT : IsWignerSymmetry T)
    (hsurj : Function.Surjective T) :
    (∃ U : E ≃ₗᵢ[ℂ] E, ∀ x, ∃ lam : ℂ, ‖lam‖ = 1 ∧ T x = lam • U x) ∨
    (∃ U : E → E, IsAntiunitary U ∧ ∀ x, ∃ lam : ℂ, ‖lam‖ = 1 ∧ T x = lam • U x) := by

  classical
  obtain ⟨s, bs, -⟩ := exists_hilbertBasis ℂ E
  have hne : Nonempty s := by
    by_contra hcon
    rw [not_nonempty_iff] at hcon
    obtain ⟨x, y, hxy⟩ := exists_pair_ne E
    refine hxy ?_
    have hrepr : bs.repr x = bs.repr y := by
      ext i
      exact (hcon.false i).elim
    simpa using congrArg bs.repr.symm hrepr
  obtain ⟨o⟩ := hne
  exact wigner_symmetry_hilbert bs o hT hsurj
