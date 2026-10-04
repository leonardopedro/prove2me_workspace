-- Generated from ChapterGradedHashimoto.lean — theorem BookProof.GradedHashimoto.gradedHamiltonianAlg_otimes
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterStoneBridge
import Mathlib
import Definitions.Def_ChapterGradedHashimoto
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterYangMillsGhostSector
import Definitions.Def_ChapterA4
open BookProof.FockSecondQuantization
open BookProof.YangMillsGhost
open BookProof.GradedHashimoto



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock
open BookProof.GradedFriedrichs
open BookProof.ChapterStoneResolvent BookProof.StoneBridge

noncomputable section

theorem BookProof.GradedHashimoto.gradedHamiltonianAlg_otimes (colB colF : ℕ → (ℕ →₀ ℂ)) (v : FockAlg) (w : FermiAlg) :
    gradedHamiltonianAlg colB colF (otimes v w)
      = otimes (dGamma colB v) w + otimes v (dGammaF colF w) := by sorry
