-- Generated from ChapterQuantumGravityFock.lean — theorem BookProof.QuantumGravityFock.qgGradedFock_not_bounded
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
import Mathlib
import Definitions.Def_ChapterQuantumGravityFock
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterYangMillsGhostSector
open BookProof.FockOneParticleGap
open BookProof.FockSecondQuantization
open BookProof.YangMillsGhost
open BookProof.QuantumGravityFock



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.FockOfFock BookProof.NavierStokesFlow.FullEsa
open BookProof.FarisLavine BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization

noncomputable section

theorem BookProof.QuantumGravityFock.qgGradedFock_not_bounded (omega g : ℕ → ℝ) (homega : omega = 0)
    (hg : ∀ C : ℝ, ∃ a, C < |g a|) :
    ¬ ∃ C : ℝ, ∀ f : lpFiniteModes GradedIdx, ‖qgGradedHam omega g f‖ ≤ C * ‖f‖ := by sorry
