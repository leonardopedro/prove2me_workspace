-- Generated from ChapterQgCouplingDGammaSum.lean — solution of BookProof.QgCouplingDGammaSum.dGammaOp_diagCol_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterQgCouplingDGammaSum
import Theorems.Thm_BookProof_QgCouplingDGammaSum_occEnergy_nonneg
import Theorems.Thm_BookProof_QgCouplingDGammaSum_dGammaOp_diagCol_eq
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_ikebeKato_momentum
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
open BookProof.QgCouplingDGammaSum




open BookProof.FockSecondQuantization
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.FockOneParticleGap
open BookProof.NavierStokesFlow.IkebeKato

noncomputable section

variable {ι : Type*}

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {lam : ℕ → ℝ} (hlam : ∀ k, 0 ≤ lam k) :
    EssentiallySelfAdjointOn (lpFiniteModes Conf) (dGammaOp (diagCol lam)) := by

  rw [dGammaOp_diagCol_eq]
  exact ikebeKato_momentum (occEnergy lam) (occEnergy_nonneg hlam)
