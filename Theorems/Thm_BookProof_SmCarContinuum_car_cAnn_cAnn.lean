-- Generated from ChapterSmCarContinuum.lean — theorem BookProof.SmCarContinuum.car_cAnn_cAnn
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

theorem BookProof.SmCarContinuum.car_cAnn_cAnn (i j : ℕ) (ψ : CFock) :
    cAnn i (cAnn j ψ) + cAnn j (cAnn i ψ) = 0 := by sorry
