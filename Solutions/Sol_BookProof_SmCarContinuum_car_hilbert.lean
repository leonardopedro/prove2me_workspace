-- Generated from ChapterSmCarContinuum.lean — solution of BookProof.SmCarContinuum.car_hilbert
import Mathlib
import Definitions.Def_ChapterSmCarContinuum
import Theorems.Thm_BookProof_SmCarContinuum_car_smeared
open BookProof.SmCarContinuum




open BookProof.QuantumGravityFock
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.IkebeKato
open scoped ENNReal NNReal

noncomputable section

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (b : HilbertBasis ℕ ℂ H) (v w : H) (ψ : CFock) :
    carAnn b v (carCre b w ψ) + carCre b w (carAnn b v ψ) = (inner ℂ v w : ℂ) • ψ := by

  have hv : carAnn b v = cAnnS (b.repr v) := rfl
  have hinner : (inner ℂ (b.repr v) (b.repr w) : ℂ) = inner ℂ v w := b.repr.inner_map_map v w
  rw [hv, carCre, ← hinner]
  exact car_smeared _ _ ψ

omit [CompleteSpace H] in
