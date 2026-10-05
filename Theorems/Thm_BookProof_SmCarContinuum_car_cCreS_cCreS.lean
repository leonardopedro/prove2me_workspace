-- Generated from ChapterSmCarContinuum.lean — theorem BookProof.SmCarContinuum.car_cCreS_cCreS
import Definitions.Def_ChapterQuantumGravityFock
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesIkebeKato
import Mathlib
import Definitions.Def_ChapterSmCarContinuum
import Definitions.Def_ChapterRieszFischer
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.ChapterRieszFischer
open BookProof.SmCar
open BookProof.SmCarContinuum



open BookProof.QuantumGravityFock
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.IkebeKato
open scoped ENNReal NNReal

noncomputable section

theorem BookProof.SmCarContinuum.car_cCreS_cCreS (f g : Ell2) (ψ : CFock) :
    cCreS f (cCreS g ψ) + cCreS g (cCreS f ψ) = 0 := by sorry
