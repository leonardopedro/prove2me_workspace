-- Generated from ChapterGradedHashimoto.lean — solution of BookProof.GradedHashimoto.gradedHamiltonianB_symmetricOn
import Mathlib
import Definitions.Def_ChapterGradedHashimoto
import Theorems.Thm_BookProof_GradedFriedrichs_gradedHamiltonian_symmetricOn
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
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterYangMillsGhostSector
open BookProof.GradedHashimoto




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock
open BookProof.GradedFriedrichs
open BookProof.ChapterStoneResolvent BookProof.StoneBridge
open BookProof.FockSecondQuantization
open BookProof.HermiteGalerkin
open BookProof.NavierStokesFlow.IkebeKato
open BookProof.YangMillsGhost

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {ε : ℕ ≃ GConf} {colB colF : ℕ → (ℕ →₀ ℂ)}
    (hb : IsHermCol colB) (hf : IsHermCol colF) :
    SymmetricOn (finiteModeDomain (l2BasisN ε)) (gradedHamiltonianB ε colB colF) := by

  intro x y
  exact gradedHamiltonian_symmetricOn hb hf
    (LinearEquiv.ofEq _ _ (finiteModeDomain_l2BasisN ε) x)
    (LinearEquiv.ofEq _ _ (finiteModeDomain_l2BasisN ε) y)
