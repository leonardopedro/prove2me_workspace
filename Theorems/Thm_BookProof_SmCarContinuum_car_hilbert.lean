-- Generated from ChapterSmCarContinuum.lean — theorem BookProof.SmCarContinuum.car_hilbert
import Definitions.Def_ChapterQuantumGravityFock
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesIkebeKato
import Mathlib
import Definitions.Def_ChapterSmCarContinuum
open BookProof.SmCarContinuum

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]



open BookProof.QuantumGravityFock
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.IkebeKato
open scoped ENNReal NNReal

noncomputable section

theorem BookProof.SmCarContinuum.car_hilbert (b : HilbertBasis ℕ ℂ H) (v w : H) (ψ : CFock) :
    carAnn b v (carCre b w ψ) + carCre b w (carAnn b v ψ) = (inner ℂ v w : ℂ) • ψ := by sorry
