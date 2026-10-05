-- Generated from ChapterGradedHashimoto.lean — theorem BookProof.GradedHashimoto.gradedHamiltonianB_quadForm_nonneg
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterFermionFock
import Definitions.Def_ChapterGradedFock
import Definitions.Def_ChapterGradedFriedrichs
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterStoneBridge
import Mathlib
import Definitions.Def_ChapterGradedHashimoto
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterYangMillsGhostSector
open BookProof.FockSecondQuantization
open BookProof.HermiteGalerkin
open BookProof.NavierStokesFlow.IkebeKato
open BookProof.YangMillsGhost
open BookProof.GradedHashimoto



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock
open BookProof.GradedFriedrichs
open BookProof.ChapterStoneResolvent BookProof.StoneBridge

noncomputable section

theorem BookProof.GradedHashimoto.gradedHamiltonianB_quadForm_nonneg {ε : ℕ ≃ GConf} {colB colF : ℕ → (ℕ →₀ ℂ)}
    (hb : IsPosCol colB) (hf : IsPosCol colF) (x : finiteModeDomain (l2BasisN ε)) :
    0 ≤ quadForm (gradedHamiltonianB ε colB colF) x := by sorry
