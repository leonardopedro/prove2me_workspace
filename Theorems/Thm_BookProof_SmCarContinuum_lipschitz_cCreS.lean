-- Generated from ChapterSmCarContinuum.lean — theorem BookProof.SmCarContinuum.lipschitz_cCreS
import Definitions.Def_ChapterQuantumGravityFock
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesIkebeKato
import Mathlib
import Definitions.Def_ChapterSmCarContinuum
import Definitions.Def_ChapterRieszFischer
open BookProof.ChapterRieszFischer
open BookProof.SmCarContinuum



open BookProof.QuantumGravityFock
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.IkebeKato
open scoped ENNReal NNReal

noncomputable section

theorem BookProof.SmCarContinuum.lipschitz_cCreS : LipschitzWith 1 (fun f : Ell2 => cCreS f) := by sorry
