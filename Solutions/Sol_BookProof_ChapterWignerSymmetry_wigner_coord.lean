-- Generated from ChapterWignerSymmetry.lean — solution of BookProof.ChapterWignerSymmetry.wigner_coord
import Mathlib
import Definitions.Def_ChapterWignerSymmetry
import Theorems.Thm_BookProof_ChapterWignerSymmetry_key_global
import Theorems.Thm_BookProof_ChapterWignerSymmetry_coord_of_key
open BookProof.ChapterWignerSymmetry



open scoped InnerProductSpace ComplexConjugate
open Finset


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


variable {T : E → E}

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable {T : E → E}
variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {S : (ι → ℂ) → (ι → ℂ)} {o : ι}

set_option maxHeartbeats 1000000 in
theorem solution (hS : WignerCoord S o) :
    (∀ v, ∃ lam : ℂ, ‖lam‖ = 1 ∧ ∀ k, S v k = lam * v k) ∨
    (∀ v, ∃ lam : ℂ, ‖lam‖ = 1 ∧ ∀ k, S v k = lam * conj (v k)) := by

  rcases key_global hS with h | h
  · left
    intro v
    simpa using coord_of_key hS (RingHom.id ℂ) (by simp) (by simp) (by simpa using h) v
  · right
    intro v
    simpa using
      coord_of_key hS (starRingEnd ℂ) (fun z => Complex.norm_conj z) (fun z => by simp) h v
