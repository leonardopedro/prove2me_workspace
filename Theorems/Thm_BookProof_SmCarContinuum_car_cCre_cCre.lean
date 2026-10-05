-- Generated from ChapterSmCarContinuum.lean — theorem BookProof.SmCarContinuum.car_cCre_cCre
import Definitions.Def_ChapterQuantumGravityFock
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesIkebeKato
import Mathlib
import Definitions.Def_ChapterSmCarContinuum
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.SmCar
open BookProof.SmCarContinuum



open BookProof.QuantumGravityFock
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.IkebeKato
open scoped ENNReal NNReal

noncomputable section

theorem BookProof.SmCarContinuum.car_cCre_cCre (i j : ℕ) (ψ : CFock) :
    cCre i (cCre j ψ) + cCre j (cCre i ψ) = 0 := by sorry
