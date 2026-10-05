-- Generated from ChapterFreeFieldBornFiberCard.lean — solution of BookProof.ChapterFreeFieldBornFiberCard.bornFiber_card
import Mathlib
import Definitions.Def_ChapterFreeFieldBornFiberCard
open BookProof.ChapterFreeFieldBornFiberCard



open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSurj
open BookProof.ChapterFreeFieldBornCont BookProof.ChapterFreeFieldBornSignGauge
open BookProof.ChapterFreeFieldBornSignFiber BookProof.ChapterFreeFieldBornSectionBij
open BookProof.ChapterFreeFieldBornQuotient


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {p : ↥(stdSimplex ℝ (Fin n))}
    (hp : ∀ k, 0 < (p : Fin n → ℝ) k) :
    Nat.card ↥(bornMapSphere n ⁻¹' {p}) = 2 ^ n := by

  convert Nat.card_congr (bornFiberEquiv hp |> Equiv.symm) using 1
  norm_num [Nat.card_pi]
