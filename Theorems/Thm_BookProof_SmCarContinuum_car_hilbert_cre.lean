-- Generated from ChapterSmCarContinuum.lean — theorem BookProof.SmCarContinuum.car_hilbert_cre
import Definitions.Def_ChapterQuantumGravityFock
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesIkebeKato
import Mathlib
import Definitions.Def_ChapterSmCarContinuum
open BookProof.SmCarContinuum



open BookProof.QuantumGravityFock
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.IkebeKato
open scoped ENNReal NNReal

noncomputable section

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

theorem BookProof.SmCarContinuum.car_hilbert_cre (b : HilbertBasis ℕ ℂ H) (v w : H) (ψ : CFock) :
    carCre b v (carCre b w ψ) + carCre b w (carCre b v ψ) = 0 := by sorry
