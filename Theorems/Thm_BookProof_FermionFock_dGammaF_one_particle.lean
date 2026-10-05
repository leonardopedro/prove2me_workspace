-- Generated from ChapterFermionFock.lean — theorem BookProof.FermionFock.dGammaF_one_particle
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterFockSecondQuantization
import Mathlib
import Definitions.Def_ChapterFermionFock
open BookProof.FermionFock



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

theorem BookProof.FermionFock.dGammaF_one_particle (col : ℕ → (ℕ →₀ ℂ)) (k : ℕ) :
    dGammaF col (Finsupp.single ({k} : FConf) 1)
      = ∑ j ∈ (col k).support, (col k) j • Finsupp.single ({j} : FConf) (1 : ℂ) := by sorry
