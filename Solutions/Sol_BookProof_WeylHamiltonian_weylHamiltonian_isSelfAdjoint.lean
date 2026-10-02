-- Generated from ChapterWeylHamiltonian.lean — solution of BookProof.WeylHamiltonian.weylHamiltonian_isSelfAdjoint
import Mathlib
import Definitions.Def_ChapterWeylHamiltonian
open BookProof.WeylHamiltonian




open ContinuousLinearMap
open scoped BigOperators

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
hB : ∀ a, IsSelfAdjoint (B a)) (x : H) :
    0 ≤ RCLike.re (inner ℂ ((weylHamiltonian π B) x) x) :=
  (weylHamiltonian_isPositive π B hπ hB).2 x

theorem solution {n m : ℕ}
    (π : Fin n → H →L[ :=
  ℂ] H) (B : Fin m → H →L[ℂ] H)
      (hπ : ∀ i, IsSelfAdjoint (π i)) (hB : ∀ a, IsSelfAdjoint (B a)) :
      IsSelfAdjoint (weylHamiltonian π B) := by
    have h_sq_selfAdjoint : ∀ i, IsSelfAdjoint ((π i) ∘L (π i)) := by
      simp_all [IsSelfAdjoint]
      simp_all [star, ContinuousLinearMap.ext_iff]
    have h_B_sq_selfAdjoint : ∀ a, IsSelfAdjoint ((B a) ∘L (B a)) := by
      simp_all [IsSelfAdj
