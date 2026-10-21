-- Generated from ChapterSmCarContinuum.lean — solution of BookProof.SmCarContinuum.car_hilbert_cre
import Mathlib
import Definitions.Def_ChapterSmCarContinuum
import Theorems.Thm_BookProof_SmCarContinuum_car_cCreS_cCreS
open BookProof.SmCarContinuum




open BookProof.QuantumGravityFock
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.IkebeKato
open scoped ENNReal NNReal

noncomputable section

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (b : HilbertBasis ℕ ℂ H) (v w : H) (ψ : CFock) :
    carCre b v (carCre b w ψ) + carCre b w (carCre b v ψ) = 0 := car_cCreS_cCreS (b.repr v) (b.repr w) ψ
