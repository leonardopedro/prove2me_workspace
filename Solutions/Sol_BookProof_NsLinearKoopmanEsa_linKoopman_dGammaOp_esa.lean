-- Generated from ChapterNsLinearKoopmanEsa.lean — solution of BookProof.NsLinearKoopmanEsa.linKoopman_dGammaOp_esa
import Mathlib
import Definitions.Def_ChapterNsLinearKoopmanEsa
import Theorems.Thm_BookProof_NsLinearKoopmanEsa_linKvnPoly_eq_fqPoly
import Theorems.Thm_BookProof_QuadFockEsa_dGamma_fqPoly_essentiallySelfAdjointOn_core
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterQuadraticFockEsa
open BookProof.NsLinearKoopmanEsa




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.NsKoopman
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.FockSecondQuantization BookProof.QuadFockEsa
open BookProof.FockSecondQuantization
open BookProof.QuadFockEsa

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (e : ℕ ≃ (Fin d →₀ ℕ)) (A : Fin d → Fin d → ℝ) (c : Fin d → ℝ) :
    EssentiallySelfAdjointOn (BookProof.NavierStokesFlow.lpFiniteModes Conf)
      (dGammaOp (hermCol e (linKvnPoly A c))) := by

  rw [linKvnPoly_eq_fqPoly]
  exact dGamma_fqPoly_essentiallySelfAdjointOn_core e _ _ _ _ _
