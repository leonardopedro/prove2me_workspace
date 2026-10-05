-- Generated from ChapterNsLinearKoopmanEsa.lean — solution of BookProof.NsLinearKoopmanEsa.linKoopman_dGammaOp_esa
import Mathlib
import Definitions.Def_ChapterNsLinearKoopmanEsa
import Theorems.Thm_BookProof_NsLinearKoopmanEsa_linKvnPoly_eq_fqPoly
import Theorems.Thm_BookProof_QuadFockEsa_dGamma_fqPoly_essentiallySelfAdjointOn_core
open BookProof.NsLinearKoopmanEsa




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.FockSecondQuantization BookProof.QuadFockEsa

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (e : ℕ ≃ (Fin d →₀ ℕ)) (A : Fin d → Fin d → ℝ) (c : Fin d → ℝ) :
    EssentiallySelfAdjointOn (BookProof.NavierStokesFlow.lpFiniteModes Conf)
      (dGammaOp (hermCol e (linKvnPoly A c))) := by

  rw [linKvnPoly_eq_fqPoly]
  exact dGamma_fqPoly_essentiallySelfAdjointOn_core e _ _ _ _ _
