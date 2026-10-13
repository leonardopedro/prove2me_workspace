-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.qgGradedSymbol_oneGhost
import Mathlib
import Definitions.Def_ChapterQuantumGravityFock
import Theorems.Thm_BookProof_NavierStokesFlow_FockOfFock_confEnergy_zero
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesFockSpace
import Definitions.Def_ChapterNavierStokesFullEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterYangMillsGhostSector
open BookProof.QuantumGravityFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.FockOfFock BookProof.NavierStokesFlow.FullEsa
open BookProof.FarisLavine BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization
open BookProof.FockOneParticleGap
open BookProof.YangMillsGhost

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (omega g : ℕ → ℝ) (a : ℕ) :
    qgGradedSymbol omega g (0, ({a} : FermConf)) = g a := by

  simp [qgGradedSymbol, BookProof.NavierStokesFlow.FockOfFock.confEnergy_zero, ghostEnergy]
