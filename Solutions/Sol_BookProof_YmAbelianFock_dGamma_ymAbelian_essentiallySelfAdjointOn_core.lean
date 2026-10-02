-- Generated from ChapterYangMillsAbelianFockEsa.lean — solution of BookProof.YmAbelianFock.dGamma_ymAbelian_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianFockEsa
import Theorems.Thm_BookProof_YmAbelianFock_ymAbelianHermCol_eq
import Theorems.Thm_BookProof_FullQuadratic_polySym_fqPoly
import Theorems.Thm_BookProof_HermiteBand_isBand2_fqPoly
import Theorems.Thm_BookProof_QuadFockEsa_dGamma_hermCol_essentiallySelfAdjointOn_core




open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FockSecondQuantization BookProof.NavierStokesFlow
open BookProof.HermiteGalerkin BookProof.FarisLavine
open BookProof.YangMillsHermite BookProof.FullQuadratic BookProof.YangMillsAbelianEsa
open BookProof.YangMillsFriedrichs
open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.EsaClosure BookProof.StoneBridge

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (e : ℕ ≃ (Fin 99 →₀ ℕ)) :
    EssentiallySelfAdjointOn (lpFiniteModes Conf) (dGammaOp (ymAbelianHermCol e)) := by

  rw [ymAbelianHermCol_eq]
  refine dGamma_hermCol_essentiallySelfAdjointOn_core e ?_ ?_
  · rw [ymAbelianPoly_eq_fqPoly]
    exact polySym_fqPoly _ _ _ _ _
  · rw [ymAbelianPoly_eq_fqPoly]
    exact isBand2_fqPoly _ _ _ _ _
