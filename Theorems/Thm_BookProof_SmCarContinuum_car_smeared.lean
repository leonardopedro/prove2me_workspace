-- Generated from ChapterSmCarContinuum.lean — theorem BookProof.SmCarContinuum.car_smeared
import Definitions.Def_ChapterQuantumGravityFock
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesIkebeKato
import Mathlib
import Definitions.Def_ChapterSmCarContinuum
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterRieszFischer
open BookProof.ChapterRieszFischer
open BookProof.SmCarContinuum



open BookProof.QuantumGravityFock
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.IkebeKato
open scoped ENNReal NNReal

noncomputable section

theorem BookProof.SmCarContinuum.car_smeared (f g : Ell2) (ψ : CFock) :
    cAnnS f (cCreS g ψ) + cCreS g (cAnnS f ψ) = (inner ℂ f g : ℂ) • ψ := by sorry
