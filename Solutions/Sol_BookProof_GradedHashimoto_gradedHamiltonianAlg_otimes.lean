-- Generated from ChapterGradedHashimoto.lean — solution of BookProof.GradedHashimoto.gradedHamiltonianAlg_otimes
import Mathlib
import Definitions.Def_ChapterGradedHashimoto
import Theorems.Thm_BookProof_GradedFock_liftFst_otimes
import Theorems.Thm_BookProof_GradedFock_liftSnd_otimes
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterFermionFock
import Definitions.Def_ChapterGradedFock
import Definitions.Def_ChapterGradedFriedrichs
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterYangMillsGhostSector
open BookProof.GradedHashimoto




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock
open BookProof.GradedFriedrichs
open BookProof.ChapterStoneResolvent BookProof.StoneBridge
open BookProof.FockSecondQuantization
open BookProof.YangMillsGhost

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (colB colF : ℕ → (ℕ →₀ ℂ)) (v : FockAlg) (w : FermiAlg) :
    gradedHamiltonianAlg colB colF (otimes v w)
      = otimes (dGamma colB v) w + otimes v (dGammaF colF w) := by

  change liftFst (dGamma colB) (otimes v w) + liftSnd (dGammaF colF) (otimes v w) = _
  rw [liftFst_otimes, liftSnd_otimes]
